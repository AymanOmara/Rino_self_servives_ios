//
//  SettingsView.swift
//  Rino
//
//  Created by Ayman Omara on 06/07/2022.
//

import SwiftUI

struct SettingsView: View {
    @State var isActive = false
    var body: some View {
        ZStack {
            List{
                NavigationLink {
                    PersonalProfileView()
                } label: {
                    SettingsCell(imageName: "gear", text: "اعدادات الحساب")
                }
                
                NavigationLink {
                    ChnagePassowrdView()
                } label: {
                    SettingsCell(imageName: "lock.circle.fill", text: "تغيير كلمة السر")
                }
                
                NavigationLink {
                    CompliantsView()
                } label: {
                    SettingsCell(imageName: "list.bullet.rectangle.portrait.fill", text: "الشكاوى والمقترحات")
                }
                HStack{
                    NavigationLink(destination: WelcomeView( shouldEmpedNavigation: false), isActive: $isActive) {
                        SettingsCell(imageName: "delete.forward", text: "تسجيل الخروج")

                    }.onTapGesture {
                        print("empty")
                        UIApplication.shared.unregisterForRemoteNotifications()
                        LocalModel.shared.notificationCounter = 0
                        LocalModel.shared.registerationToken = ""
                        LocalModel.shared.setToken(token: "", refreshToken: "")
                        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                            isActive = true
                    }
                }

            }
            .environment(\.layoutDirection, .rightToLeft)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
struct SettingsCell:View{
    var imageName,text:String
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .resizable()
                .frame(width:30,height: 30)
                .foregroundColor(Color.blue)
            Text(text)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}
