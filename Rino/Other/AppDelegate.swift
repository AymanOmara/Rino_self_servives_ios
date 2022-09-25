//
//  AppDelegate.swift
//  Rino
//
//  Created by Ayman Omara on 26/08/2021.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    @Published var newNoticiation:Int = 0
    var publisher: Published<Int>.Publisher{$newNoticiation}
    
    
    
    
    
    
    private let gcmMessageIDKey = "Rino"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {  isGranted, error in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self
        
        
        Messaging.messaging().isAutoInitEnabled = true
        //        UIApplication.LaunchOptionsKey.remoteNotification
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate:MessagingDelegate{
    func registerFCM(token:String?){
        
        let accessToken = LocalModel.shared.getToken().token
        guard let token = token else{return}
        
        print(!accessToken.isEmpty && LocalModel.shared.registerationToken != token)
        if !accessToken.isEmpty && LocalModel.shared.registerationToken != token{
            
            UsersAPI.shard.registerDeviceFCM(FCMRegisterToken: token) { response, errorcase in
                guard let response = response else{return}
                if response.success == true{
                    LocalModel.shared.registerationToken = token
                }
            }
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //        registerFCM(token: fcmToken)
        //      print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        registerFCM(token: fcmToken)
        //        Messaging.messaging().token { token, error in
        //          if let error = error {
        //          } else if let token = token {
        //              self.registerFCM(token: token)
        //          }
        //        }
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                     -> Void) {
//        let userInfo = response.notification.request.content.userInfo

        
        LocalModel.shared.notificationCounter += 1
        newNoticiation = 1
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    
    //
    //    @available(iOS 13.0, *)
    //    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    //        // Called when a new scene session is being created.
    //        // Use this method to select a configuration to create the new scene with.
    //        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}


@available(iOS 13.0, *)
func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}




extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        //    let userInfo = notification.request.content.userInfo
        
        
        
        // Change this to your preferred presentation option
        
        if #available(iOS 14.0, *) {
            completionHandler([[.banner,.list , .sound]])
        } else {
            completionHandler([[.alert , .sound]])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        guard let userInfo = userInfo as NSDictionary? as? [String: Any] else {return}
        
        let id:Int = Int(userInfo["id"] as! String)!
        let processType:String = userInfo["processType"]  as! String
        let entityType:String = userInfo["entityType"] as! String
        let notificationID:String = userInfo["notificationId"] as! String
        
    
        
        UsersAPI.shard.markNotificationReaded(id: Int(notificationID) ?? 0) { response, error in
            guard let wrapedrResponse = response else{return}
            if wrapedrResponse.success == true{
                LocalModel.shared.notificationCounter -= 1
            }
        }
        
        
        let vc = UIHostingController(rootView:
                                        NavigationView{
            AllServices(notification: NotificationObject(id:id,entity: Int(entityType),processType: processType), shouldEmpedNavigation: true)
        }
        )
        //
        UIApplication.shared.windows.first?.rootViewController = vc
        
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        
        
        completionHandler()
    }
    func application(application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}
