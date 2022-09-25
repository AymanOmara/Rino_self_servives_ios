//
//  WelcomeView.swift
//  Rino
//
//  Created by Ayman Omara on 11/07/2022.
//

import SwiftUI
import Combine
struct WelcomeView: View {
    @State var isShown = false
    @State var isSuccessLogIn = false
    var shouldEmpedNavigation:Bool
    var body: some View {
        if shouldEmpedNavigation{
            
                ZStack{
                    VStack{
                        VStack{
                            Text("شركه رينو المتحده المحدوده")
                            Text("مرحبا بك في تطبيق رينو لرياده الاعمال ")
                                .padding(.top,10)
                            
                            Text("قم بتسجيل الدخول بحسابك الشخصي  لمراجعه الطلبات من كافه الادارات في المؤسسه")
                                .multilineTextAlignment(.center)
                                
                        }
                        .padding(.top,30)
                        Spacer()
                        Button {
                            isShown.toggle()
                        } label: {
                            Text("تسجيل الدخول")
                                .foregroundColor(.white)
                                .padding(.vertical,5)
                                .frame(width:UIScreen.main.bounds.width-40)
                                
                                .background(Color.orange)
                                .cornerRadius(5)
                            
                        }
                        .padding(.bottom,40)
                        
                    }
                    BottomCard(content: {
                        if isShown{
                            LoginView(isShown: $isShown, isSuccessLogIn: $isSuccessLogIn)
                        }
                    }, isShown: $isShown,cancel: $isShown)
                    NavigationLink(destination: AllServices(shouldEmpedNavigation: shouldEmpedNavigation), isActive: $isSuccessLogIn) {
                        EmptyView()
                    }
                }
                .environment(\.layoutDirection, .rightToLeft)
            
            .navigationBarBackButtonHidden(true)
        }else{
            
                ZStack{
                    VStack{
                        VStack{
                            Text("شركه رينو المتحده المحدوده")
                            Text("مرحبا بك في تطبيق رينو لرياده الاعمال ")
                                .padding(.top,10)
                            
                            Text("قم بتسجيل الدخول بحسابك الشخصي  لمراجعه الطلبات من كافه الادارات في المؤسسه")
                                .multilineTextAlignment(.center)
                                
                        }
                        .padding(.top,30)
                        Spacer()
                        Button {
                            isShown.toggle()
                        } label: {
                            Text("تسجيل الدخول")
                                .foregroundColor(.white)
                                .padding(.vertical,5)
                                .frame(width:UIScreen.main.bounds.width-40)
                                
                                .background(Color.orange)
                                .cornerRadius(5)
                            
                        }
                        .padding(.bottom,40)
                        
                    }
                    BottomCard(content: {
                        if isShown{
                            LoginView(isShown: $isShown, isSuccessLogIn: $isSuccessLogIn)
                        }
                    }, isShown: $isShown,cancel: $isShown)
                    NavigationLink(destination: AllServices(shouldEmpedNavigation: shouldEmpedNavigation), isActive: $isSuccessLogIn) {
                        EmptyView()
                    }
                }
                .environment(\.layoutDirection, .rightToLeft)
            
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView( shouldEmpedNavigation: false)
    }
}
