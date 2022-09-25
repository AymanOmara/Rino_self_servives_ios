//
//  SeeAllViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 12/09/2021.
//
import Foundation
import Combine
class SeeAllViewModel:ObservableObject{
    @Published var isshowLoading = false
    var destination:String?
    var startDate,endDate:String!
    
    var currentPageNumber = 1
    
    var pagesAmount = 1
    @Published var items = [PaymentItem]()
    
    @Published var errorMessage = ""
    @Published var errorcase = NetworkErrorCase.none
    
    func constructTheURL()->String{
        return "api/requests/\(destination!)/from/\(startDate!)/to/\(endDate!)/page/\(currentPageNumber)"
    }
    
    func fetchData(){
        errorcase = .none
        errorMessage = ""
        isshowLoading = true
        UsersAPI.shard.getPPSeeAll(url: constructTheURL()) {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isshowLoading = false
            if errorcase == .none{
                if let totalPages = response?.total{
                    self.calculatePagesNumber(total: totalPages)
                }else{
                    print("nil")
                }
                if let data = response?.data{
                    print(data.count)
                    self.items.append(contentsOf: data)
                }
            }else{
                
                if self.items.isEmpty{
                    self.errorcase = errorcase
                }else{
                    self.errorMessage = errorcase.rawValue
                }
            }
        }
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
