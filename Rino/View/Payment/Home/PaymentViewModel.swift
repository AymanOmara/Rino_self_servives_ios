//
//  PaymentViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 31/08/2021.
//

import Foundation

import Combine
import UIKit
//import UIKit
class PaymentViewModel : ObservableObject {
    var selectedFilter = "all"
    var distination = "me"
    var isMe = true
    @Published var counter = 0
    @Published var payments = PaymentProcessResponse()
    @Published var errorcase:NetworkErrorCase = .none
    @Published var notificationCounter = NotificationCount()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = true
    private var didCalled = false
    func getNotificationsCounter() {
        errorcase = .none
        UsersAPI.shard.getNotificationCounter {[weak self] data, errorCase in
            guard let self = self else{return}
            guard let data = data else {return}
            self.notificationCounter = data
            if errorCase == .none{
                guard let paymentNotificationCount = data.data?.paymentNotifies, let hrNotificationCount = data.data?.clearanceNotifies , let orderNotifies = data.data?.orderNotifies else {
                    return
                }
                self.counter = paymentNotificationCount
                LocalModel.shared.notificationCounter = paymentNotificationCount+hrNotificationCount+orderNotifies
            }
        }
    }
    
    func getPayments(){
        errorcase = .none
        
        if !isLoading{
            isLoading = true
        }
        
        if payments.data != nil || payments.data?.isEmpty == false{
            payments.data?.removeAll()
        }
        UsersAPI.shard.getPaymentProcessHome(from: distination, filter: selectedFilter) {[weak self] payments, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase != .none{
                self.errorcase = errorcase
            }else{
                if let payments = payments{
                    
                    if payments.data?.isEmpty == true || payments.success == false{
                        self.errorcase = .emptyData
                    }else{
                        self.payments = payments
                        self.getNotificationsCounter()
                    }
                }else{
                    self.errorcase = .emptyData
                }
            }
        }
    }
    init(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.publisher.receive(on: DispatchQueue.main).subscribe(on: DispatchQueue.main)
//            .sink {[weak self ] value in
//                guard let self = self else{return}
//                if self.notificationCounter.data?.paymentNotifies != nil{
//                    self.notificationCounter.data?.paymentNotifies = 1 + self.notificationCounter.data!.paymentNotifies!
//                    self.counter += 1
//                }
//            }.store(in: &cancellables)
    }
}
