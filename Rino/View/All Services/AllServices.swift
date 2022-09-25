//
//  AllServices.swift
//  Rino
//
//  Created by Ayman Omara on 12/07/2022.
//

import SwiftUI
import SkeletonUI
struct AllServices: View {
    var notification:NotificationObject?
    var shouldEmpedNavigation:Bool
    @State var shouldOpenNotification = false
    @ObservedObject private var viewModel = AllServicesViewModel()
    var body: some View {
        ZStack{
            ZStack{
                NavigationLink(isActive: $viewModel.shouldOpenNotification) {
                    if notification?.processType == "payment"{
                        PPDetailsView(id: notification!.id!, isForwordToMe: true)
                    }else if notification?.processType == "clearance"{
                        HRDetailsView(id: notification!.id!, isForwordToMe: true, entity: notification!.entity!)
                    }
                } label: {
                    EmptyView()
                }
            }
            if viewModel.errorcase != .none{
                ErrorView(action: {
                    viewModel.getPrivillage(isFromNotification: false)
                }, errorcase: viewModel.errorcase)
            }
            if viewModel.isLoading {
                VStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .skeleton(with: viewModel.isLoading)
                .shape(type: .rectangle)
            }else if !viewModel.isLoading && viewModel.isGM != nil{
                VStack{
                    Image("bannerLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.top,50)
                    NavigationLink {
                        PaymentProcessView()
                    } label: {
                        HStack{
                            Text("خدمه المدفوعات الماليه")
                                .foregroundColor(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width*0.8, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(.top,30)
                        .padding(.bottom,30)
                    }

                    NavigationLink {
                        HRHomePage()
                    } label: {
                        HStack{
                            Text("خدمه اخلاء الطرف")
                                .foregroundColor(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width*0.8, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(.bottom,30)
                    }
                    if viewModel.isGM == true{
                        NavigationLink {
                            ManagementAlerts()
                        } label: {
                            HStack{
                                Text("تنبيهات الادارة العليا")
                                    .foregroundColor(.white)
                            }
                            .frame(width: UIScreen.main.bounds.width*0.8, height: 50)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .padding(.bottom,30)
                        }
                    }
                    Spacer()
                }
                .environment(\.layoutDirection, .rightToLeft)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .navigationBarTitle("", displayMode: .inline)
            }

        }.onAppear{
//            shouldOpenNotification = notification != nil
            if viewModel.isGM == nil{
                viewModel.getPrivillage(isFromNotification: notification != nil)
            }
//            shouldOpenNotification = false
        }
    }
}

struct AllServices_Previews: PreviewProvider {
    static var previews: some View {
        AllServices(shouldEmpedNavigation: false)
    }
}
