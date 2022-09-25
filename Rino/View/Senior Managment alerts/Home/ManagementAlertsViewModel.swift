//
//  ManagementAlertsViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 03/08/2022.
//

import Foundation
class ManagementAlertsViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var requests = [PaymentOrderHomeData]()
    @Published var errorcase = NetworkErrorCase.none
    @Published var notificationCounter = 0
    
    func getNotificationsCounter() {
        UsersAPI.shard.getNotificationCounter {[weak self] data, errorCase in
            guard let self = self else{return}
            guard let data = data else {return}
            if errorCase == .none{
                guard let paymentNotificationCount = data.data?.paymentNotifies, let hrNotificationCount = data.data?.clearanceNotifies , let orderNotifies = data.data?.orderNotifies else {
                    return
                }
                self.notificationCounter = orderNotifies
                LocalModel.shared.notificationCounter = paymentNotificationCount+hrNotificationCount+orderNotifies
            }
        }
    }
    
    func getPaymentOrders(filter:String){
        errorcase = .none
        requests.removeAll()
        isLoading = true
        UsersAPI.shard.getPaymentOrder(filter: filter) {[weak self] paymentOrders, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                self.getNotificationsCounter()
                guard let payments = paymentOrders else{
                    self.errorcase = .emptyData
                    return
                }
                if payments.data?.isEmpty == false{
                    if let paymentsArray = payments.data{
                        self.requests = paymentsArray
                    }
                    
                }else{
                    self.errorcase = .emptyData
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
}
