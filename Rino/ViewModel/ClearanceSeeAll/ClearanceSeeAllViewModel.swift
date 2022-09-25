//
//  ClearanceSeeAllViewModel.swift
//  Rino
//MARK:- This class is Responsible for connecting the UI To Model Layer (See All in Clearance)
//  Created by Ayman Omara on 05/10/2021.
//

import Foundation
import Combine

class ClearanceSeeAllViewModel :ObservableObject{
    var destination:String = "me"
    var date:(startDate:String,endDate:String)!
    var currentPageNumber = 1
    @Published var data = [HRSeeAllData]()
    var pagesAmount:Int! = 1
    var totoal:Int!
    @Published var isLodaing = true
    @Published var errorcase = NetworkErrorCase.none
    @Published var errormessage = ""
    func fetchData() {
        errormessage = ""
//        if isLodaing{return}
        errorcase = .none
        isLodaing = true
        UsersAPI.shard.hrSeeAll(url: constructTheURL()) {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLodaing = false
            if errorcase == .none{
                if let value = response?.total{
                    self.calculatePagesNumber(total: value)
                }else{
                    self.calculatePagesNumber(total: 0)
                }
                guard let requests = response?.data else{
                    self.handelErrorMessage(message: nil)

                    return
                }
                self.data.append(contentsOf: requests)
            }else{
                if self.data.isEmpty == true{
                    self.errorcase = errorcase
                }else{
                    self.errormessage = errorcase.rawValue
                }
            }
        }
    }
    private func handelErrorMessage(message:String?){
        if data.isEmpty{
            errorcase = .emptyData
        }else{
            self.errormessage = message ?? MessagesToUser.timeOut.message
        }
    }

    func constructTheURL() -> String {
        return "api/clearancerequests/\(destination)/from/\(date.0)/to/\(date.1)/page/\(currentPageNumber)"
    }

    func calculatePagesNumber(total:Int){
        let temp:Float = Float(total) / 20
        let reminder = temp.fraction
        let wholeNumber = temp.whole
        if wholeNumber < 1 && wholeNumber > 0{

            pagesAmount = 1
        }
        else if reminder > 0 {

            pagesAmount = Int((Double(total) / 20.0)) + 1
        }else{
            pagesAmount = Int((Double(total) / 20.0))
        }
    }
}
