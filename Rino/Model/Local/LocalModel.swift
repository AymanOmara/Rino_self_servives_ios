//
//  LocalModel.swift
//  Rino
//  Created by Ayman Omara on 02/09/2021.
//

import Foundation
import UIKit
class LocalModel {
    
    static let shared = LocalModel()
    private var userDefaults:UserDefaults
    
    func setToken(token:String,refreshToken:String){
        
        userDefaults.set(token, forKey: Keys.token)
        userDefaults.set(refreshToken, forKey: Keys.refreshToken)
    }
    func getToken() -> (token:String,refresh:String) {
        let token = userDefaults.string(forKey: Keys.token) ?? ""
        let refresh = userDefaults.string(forKey: Keys.refreshToken) ?? ""
        return (token:token,refresh:refresh)
    }
    var notificationCounter:Int{
        set{
            userDefaults.setValue(newValue, forKey: "notificationCounter")
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }get{
            userDefaults.integer(forKey: "notificationCounter")
        }
    }
//    var shouldUploadFCMToken:Bool{
//        set{
//            userDefaults.setValue(newValue, forKey: "shouldUploadFCMToken")
//        }get{
//            userDefaults.bool(forKey: "shouldUploadFCMToken")
//        }
//    }
    var registerationToken:String{
        set{
            userDefaults.setValue(newValue, forKey: "registerationToken")
        }
        get{
            userDefaults.string(forKey: "registerationToken") ?? ""
        }
    }
    
    private init(){
        userDefaults = UserDefaults.standard
    }
}

