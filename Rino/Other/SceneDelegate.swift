//
//  SceneDelegate.swift
//  Rino
//
//  Created by Ayman Omara on 26/08/2021.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseMessaging
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?
    private let localModel = LocalModel.shared
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

            
        
        if localModel.getToken().token == "" {
            
            let vc = UIHostingController(rootView:
                                            NavigationView{
                WelcomeView(shouldEmpedNavigation: true).environment(\.locale, Locale(identifier: "ar")).environment(\.layoutDirection, .rightToLeft)
            }
            )
           
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                appdelegate.newNoticiation = 1
//
//            }

            
            UIApplication.shared.windows.first?.rootViewController =  vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }else{
            registerFCM(token: Messaging.messaging().fcmToken)
            let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            let vc = UIHostingController(rootView:
                                            NavigationView{
                AllServices(shouldEmpedNavigation: true).environment(\.locale, Locale(identifier: "ar")).environment(\.layoutDirection, .rightToLeft)
            }
                                            
            )
            UIApplication.shared.windows.first?.rootViewController =  vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    @objc func fireTimer() {
//        appdelegate.newNoticiation = 1
    }
    func registerFCM(token:String?){

        let accessToken = LocalModel.shared.getToken().token
        guard let token = token else{return}
        print(token)
        print("caaaaaaaaaaaaaaaaaaaaaseeeeeeeeeeeeeeeeeeee\(!accessToken.isEmpty && LocalModel.shared.registerationToken != token)")
        if !accessToken.isEmpty && LocalModel.shared.registerationToken != token{
            
            UsersAPI.shard.registerDeviceFCM(FCMRegisterToken: token) { response, errorcase in
                guard let response = response else{return}
                if response.success == true{
                    LocalModel.shared.registerationToken = token
                }
            }
        }
//        if accessToken.isEmpty{
//            LocalModel.shared.registerationToken = token
//        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

