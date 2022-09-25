//
//  NotificationsView.swift
//  Rino
//
//  Created by Ayman Omara on 16/07/2022.
//

import SwiftUI
import Combine
import SkeletonUI
import SPAlert
import Introspect
struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    var body: some View {
        ZStack {
            
            VStack {
                if viewModel.errorcase == .none {
                    List{
                        ForEach(viewModel.data.data ?? []){ notification in
                            Section{
                                NotificationCell(item: notification, viewModel: viewModel)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            }
                        }
                        if viewModel.isLoading{
                            NotificationCell(item: NotificationData(), viewModel: viewModel)
                                .skeleton(with:viewModel.isLoading)
                                .shape(type: .rectangle)
                                .frame(height:300)
                        }
                    }
                    .introspectTableView(customize: { tableView in
                        tableView.separatorColor = .clear
                    })
                    .onAppear{
                        if viewModel.data.data == nil{
                            viewModel.fetchData()
                        }
                    }
                } else {
                    ErrorView(action: {
                        viewModel.fetchData()
                    }, errorcase: viewModel.errorcase)
                }
            }
            
            ActivityIndicator(isAnimating: $viewModel.isLoadingIndicator)
                .frame(width:50,height: 50)
            
                .SPAlert(isPresent: $viewModel.showBanner, alertView: SPAlertView(title: viewModel.alert?.title ?? "", message: viewModel.alert?.body ?? "", preset: viewModel.alert?.alertCase ?? .error))
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
struct NotificationCell:View{
    @State var item:NotificationData
    @ObservedObject var viewModel:NotificationViewModel
    var body: some View{
        VStack{
            HStack(alignment:.top){
                HStack{
                    Image(item.isread == true ? "read" :"unread")
                }
                HStack{
                    VStack(alignment:.leading){
                        Text(item.body ?? Constents.noValue)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("رقم الطلب:"+String(item.requestid ?? 0).toArabicNumber())
                    }
                }
            }.background( NavigationLink("", destination: item.process == 0 ? AnyView(PPDetailsView(id: item.requestid ?? 0, isForwordToMe: true))
        : item.process == 1 ?
                                         AnyView(HRDetailsView(id: item.requestid ?? 0, isForwordToMe: true, entity: item.entity ?? 0 )) : nil ).opacity(0))
            .padding(.top,10)
            
            Divider()
            HStack{
                Text("تعيين كمقروء")
                    .foregroundColor(.white)
            }
            .frame(width:UIScreen.main.bounds.width*0.6,height:50)
            
            .background(Color.orange)
            .cornerRadius(10)
            .padding(.bottom,10)
            .onTapGesture {
                if item.isread == false{
                    viewModel.markAsRead(id: item.notificationID ?? 0)
                }
            }
        }
    }
}
