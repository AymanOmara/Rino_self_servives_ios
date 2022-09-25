//
//  PaymentOrderSearchViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 14/08/2022.
//

import Foundation
class PaymentOrderSearchViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var message = ""
    @Published var data = [PaymentOrderItem]()
    @Published var totalPagesNumber = 0
    @Published var errorcase = NetworkErrorCase.none
    var currentPageIndex = 1
    @Published var alert:UserAlert?
    @Published var showMessage = false
    var serachedText = ""
    func getSearchedItems(){
        errorcase = .none
        if serachedText.isEmpty{
            self.showMessage = true
            alert = UserAlert(title: Constents.error, body: "هذا الحقل مطلوب", alertCase: .error)
            return
        }
        if currentPageIndex == 1{
            data.removeAll()
        }
        isLoading = true
        UsersAPI.shard.paymentOrderSearch(query: serachedText.toEnglishNumber(), pageNumber: currentPageIndex) {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                guard let response = response else{return}
                if response.data?.isEmpty == false{
                    self.totalPagesNumber = response.count ?? 0

                    self.data = response.data ?? []
                }else{
                    self.errorcase = .emptyData
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
    func resetToInitState(){
        data.removeAll()
        //errorcase = .none
    }
}
