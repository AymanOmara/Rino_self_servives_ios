//
//  NotificationViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 10/10/2021.
//

import Foundation

class NotificationViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var data: RinoNotification = RinoNotification()
    @Published var errorMessage = ""
    @Published var isLoadingIndicator = false
    @Published var showBanner = false
    @Published var errorcase = NetworkErrorCase.none
    var alert:UserAlert?
    func fetchData() {
        errorcase = .none
        isLoading = true
        UsersAPI.shard.getNotifications {[weak self] notifications, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if let notifications = notifications{
                if notifications.data?.isEmpty == true || notifications.data == nil{
                    self.errorcase = .emptyData
                }else{
                    self.data = notifications
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
    func markAsRead(id:Int){
        if isLoadingIndicator{return}else{isLoadingIndicator = true}
        UsersAPI.shard.markNotificationReaded(id: id) {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLoadingIndicator = false
            self.showBanner = true
            if errorcase == .none{
                guard let response = response else{
                    self.alert = UserAlert(title: Constents.error, body: MessagesToUser.timeOut.message, alertCase: .error)
                    return
                }
                if response.success == true{
                    self.data.data!.map { it in
                        if it.notificationID == id{
                            it.isread = true
                        }
                    }
                    self.alert = UserAlert(title: Constents.done, body: "تم تعديل البيانات بنجاح", alertCase: .done)
                }else{
                    self.alert = UserAlert(title: Constents.error, body: MessagesToUser.timeOut.message, alertCase: .error)
                }
            }else{
                self.alert = UserAlert(title: Constents.error, body: errorcase.rawValue, alertCase: .error)
            }
        }
    }
}
