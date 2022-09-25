//
//  LogInViewModel.swift
//  Rino
//MARK:- This class is Responsible for connecting the UI To Model Layer (For Log in)
//  Created by Ayman Omara on 01/09/2021.
//

import Foundation
import UIKit
import Combine
import FirebaseMessaging
class LogInViewModel:ObservableObject {
    var userName = ""
    var password = ""
    @Published  var errorMessage = ""
    @Published var isSuccessfulLogIn = false
    @Published var isLoading = false
//    @Published var isNetworkError = false
    
    func fetchData() {
        errorMessage = ""
        isLoading = true
        UsersAPI.shard.logIn(userName: userName, password: password) {[weak self] response, message in
            guard let self = self else{return}
            self.isLoading = false
//            print(response)
            if response?.access_token != nil{
                LocalModel.shared.setToken(token: (response?.access_token)!, refreshToken: (response?.refresh_token)!)
                UIApplication.shared.registerForRemoteNotifications()
                self.registerFCM(token:Messaging.messaging().fcmToken)
                self.isSuccessfulLogIn = true
            }else if response?.error != nil{
                self.errorMessage = MessagesToUser.invaliadLogIn.message
            }
            else{
                self.errorMessage = message.rawValue
            }
        }

    }
    func isEmpty()->Bool{
        if userName.isEmpty || password.isEmpty{
            errorMessage = MessagesToUser.empty.message
            return true
        }else{
            return false
        }
        
    }
    func isValidPasswordLength()->Bool{
        if password.count < 8{
            errorMessage =  MessagesToUser.invaliadLogIn.message
            return false
        }else{
            return true}
    }
    private func registerFCM(token:String?){

        let accessToken = LocalModel.shared.getToken().token
        guard let token = token else{return}
//        if accessToken.isEmpty{
//            LocalModel.shared.registerationToken = token
//        }
//        print(!accessToken.isEmpty && LocalModel.shared.registerationToken != token)
        if !accessToken.isEmpty{
            
            UsersAPI.shard.registerDeviceFCM(FCMRegisterToken: token) { response, errorcase in
                guard let response = response else{return}
                if response.success == true{
                    LocalModel.shared.registerationToken = token
                }
            }
        }
    }
  }
