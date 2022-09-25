//
//  ViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 14/08/2022.
//

import Foundation
class PaymentOrderSeeAllViewModel:ObservableObject{
    @Published var isLoading = false
    var destination:String?
    var startDate,endDate:String!
    
    var currentPageNumber = 1
    
    var pagesAmount = 1
    @Published var items = [PaymentOrderItem]()
    
    @Published var errorMessage = ""
    @Published var errorcase = NetworkErrorCase.none
    func fetchData(){
        isLoading = true
        errorcase = .none
        if currentPageNumber == 1{
            items.removeAll()
        }
        UsersAPI.shard.getAllPaymentOrder(path: url) {[weak self] orders, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if self.currentPageNumber == 1{
                self.pagesAmount = orders?.count ?? 1
            }
            if errorcase == .none{
                if let orders = orders{
                    self.items.append(contentsOf: orders.data ?? [])
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
    
    private var url:String{
        return "api/orders/from/\(startDate!)/to/\(endDate!)/page/\(currentPageNumber)"
    }
}
