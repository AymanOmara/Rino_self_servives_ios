//
//  HRSearchViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 05/07/2022.
//

import Foundation
class HRSearchViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var message = ""
    @Published var data = [HRSearchData]()
    @Published var totalPagesNumber = 0
    @Published var errorcase = NetworkErrorCase.none
    var currentPageIndex = 1
    @Published var alert:UserAlert?
    @Published var showMessage = false
    var serachedText = ""
    func getSearchedItems(){

        if serachedText.isEmpty{
            self.showMessage = true
            alert = UserAlert(title: Constents.error, body: "هذا الحقل مطلوب", alertCase: .error)
            return
        }
        if currentPageIndex == 1{
            data.removeAll()
        }
        isLoading = true
        errorcase = .none
        UsersAPI.shard.hrSearch(query: serachedText.toEnglishNumber(), pageNumber: currentPageIndex) {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                guard let response = response else{return}
                if response.data?.isEmpty == false{
                    self.calculatePagesNumber(total: response.total ?? 0)
                    self.data = response.data ?? []
                }else{
                    self.errorcase = .emptyData
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
    func calculatePagesNumber(total:Int){
        let temp:Float = Float(total) / 20
        let reminder = temp.fraction
        let wholeNumber = temp.whole
        if wholeNumber < 1 && wholeNumber > 0{

            totalPagesNumber = 1
        }
        else if reminder > 0 {

            totalPagesNumber = Int((Double(total) / 20.0)) + 1
        }else{
            totalPagesNumber = Int((Double(total) / 20.0))
        }
        
    }
}
