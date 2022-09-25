//
//  ManagementAlerts.swift
//  Rino
//
//  Created by Ayman Omara on 02/08/2022.
//

import SwiftUI
import Introspect
import SkeletonUI
struct ManagementAlerts: View {
    @State var selectedFliter = "weak"
    @State var selectedArabic = "الاسبوع الحالي"
    let refreshHelper = RefreshHelper(filter: "all")
    @ObservedObject private var viewModel = ManagementAlertsViewModel()
    var body: some View {
        VStack{
            Text(LocalizedStringKey("managment_alerts"))
                .font(.system(size: 20))
                .foregroundColor(.rinoBrown)
                .fontWeight(.bold)
                .padding(.vertical,5)
            FiltersView(englishFilters:Constents.managmentAlertsFilters,arabicFilters: Constents.managmentAlertsArabicFilters,selectedFilter: $selectedFliter.onChange(filterDidChange), selectedArabicFilter: $selectedArabic)
            if viewModel.errorcase != .none{
                ErrorView(action: {
                    viewModel.getPaymentOrders(filter: selectedFliter)
                }, errorcase: viewModel.errorcase)
            }
            
            if viewModel.errorcase == .none{
                ZStack{
                    
                    List{
                        ForEach(viewModel.requests){ request in
                            Section{
                                ManagementAlertCard(item: request)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                        if viewModel.isLoading{
                            HomePaymentCell(item: PPData(), isMe: false)
                                .skeleton(with: viewModel.isLoading)
                                .shape(type: .rectangle)
                                .frame(height:200)
                        }
                        
                    }.introspectTableView { tableView in
                        tableView.separatorColor = .clear
                        tableView.backgroundView = nil
                        tableView.backgroundColor = nil
                        tableView.showsVerticalScrollIndicator = false
                        let control = UIRefreshControl()
                        
                        refreshHelper.parent = self
                        refreshHelper.refreshControl = control
                        
                        control.addTarget(refreshHelper, action: #selector(RefreshHelper.init(filter:selectedFliter).didRefresh), for: .valueChanged)
                        tableView.refreshControl = control
                    }
                    .padding(.top,20)
                    .padding(.horizontal,15)
                }                .background(
                    Rectangle()
                        .fill(Color.listBackground)
                        .cornerRadius(50, corners: [.topLeft, .topRight])
                )
                .padding(.top,10)
            }
        }.onAppear{
            if viewModel.requests.isEmpty{
                viewModel.getPaymentOrders(filter: selectedFliter)
            }
        }
        .navigationBarItems(trailing:
                                
                                HStack{
            
            NavigationLink(destination: PaymentOrderSearchView()) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.rinoBrown)
            }
            NavigationLink(destination: NotificationsView()) {
                Image(systemName: "bell.fill")
                    .foregroundColor(Color.rinoBrown)
                    .overlay(Badge(count: $viewModel.notificationCounter))
            }
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "person.fill")
                    .foregroundColor(Color.rinoBrown)
            }
        }
        )
    }
    func filterDidChange(filter:String){
        viewModel.getPaymentOrders(filter: filter)
    }
    class RefreshHelper{
        var parent: ManagementAlerts?
        var refreshControl: UIRefreshControl?
        var filter:String!
        @objc func didRefresh() {
            guard let parent = parent, let refreshControl = refreshControl else { return }
            parent.viewModel.getPaymentOrders(filter: filter)
            
            refreshControl.endRefreshing()
        }
        init(filter:String){
            self.filter = filter
        }
    }
}

struct ManagementAlerts_Previews: PreviewProvider {
    static var previews: some View {
        ManagementAlerts()
    }
}
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
