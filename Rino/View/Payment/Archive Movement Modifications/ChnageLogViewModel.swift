//
//  ChnageLogViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 03/07/2022.
//

import Foundation
import Combine

final class ChnageLogViewModel:ObservableObject{
    var id:Int!
    @Published var isLoading = false
    @Published var data = [ChnageLogItem]()
    @Published var errorcase = NetworkErrorCase.none
    @Published var isSuccess = false
    
    func getChangeLog(){
        isLoading = true
        UsersAPI.shard.chnageLog(requestID: id) {[weak self] logs, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                guard let logs = logs else{return}
                if logs.status == true{
                    if logs.data?.isEmpty == true{
                        self.errorcase = .emptyData
                    }else{
                        self.data = logs.data ?? []
                    }
                }
            }else{
                self.errorcase = errorcase
            }

            
        }
//        Network.shared.getChangeLog(id: id) {[weak self] log, statusCode, message in
//            guard let self = self else{return}
//            if statusCode == 200{
//                self.isSuccess = true
//                if log?.data?.isEmpty == false{
//                    guard let data = log?.data else{return}
//                    self.data = data
//
//                }else{
//                    self.message = "لم يتم تعديل المبلغ لهذا الطلب من قبل"
//                }
//                self.isLoading = false
//            }
//            else if message.contains("time out"){
//                self.isLoading = false
//                self.message = MessagesToUser.timeOut.message
//            }else if message.contains("offline")  {
//                self.isLoading = false
//                self.message = MessagesToUser.noConnection.message
//            }else if statusCode == 401{
//                self.refreshToken {self.getChangeLog()}
//            }
//            else if log?.message?.isEmpty == false{
////                self.message = "لا تتوافر لديك الصلاحيات الكافيه لعرض المعلومات"
//                self.isLoading = false
//            }
//        }
    }

}
