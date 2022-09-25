//
//  ClearanceViewModel.swift
//  Rino
//MARK:- This class is Responsible for connecting The UI To Model Layer (For the clearance process)
//  Created by Ayman Omara on 03/10/2021.
//

import Foundation
import Combine
class ClearanceViewModel:ObservableObject{
    var selectedArabicFilter = "الكل"
    var duration = "all"
    var destination  = "me"
    @Published var isLoading = false
    @Published var data = HRHomePageResponse()
    @Published var notificationCounter = NotificationCount()
    @Published var errorcase = NetworkErrorCase.none
    @Published var counter = 0
    var isME = true
    
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
                self.counter = hrNotificationCount
                LocalModel.shared.notificationCounter = paymentNotificationCount+hrNotificationCount+orderNotifies
            }
        }
    }

    
    func fetchData(){
        errorcase = .none
        isLoading = true
        if data.data != nil{
            data.data?.removeAll()
        }
        UsersAPI.shard.hrHome(from: destination, filter: duration) {[weak self] hrRequests, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if let requests = hrRequests{
                
                
                if requests.data?.isEmpty == true{
                    self.errorcase = .emptyData
                }else if requests.success == false{
                    self.errorcase = .emptyData
                }
                else{
                    self.data = requests
                    self.getNotificationsCounter()
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
    
}
