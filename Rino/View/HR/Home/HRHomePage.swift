//
//  HRHomePage.swift
//  Rino
//
//  Created by Ayman Omara on 18/07/2022.
//

import SwiftUI
import Combine
import SkeletonUI
import Introspect
struct HRHomePage: View {
    @State var selectedFliter = "all"
    @State var selectedArabic = "الكل"
    
    let refreshHelper = RefreshHelper()
    @ObservedObject public var viewModel = ClearanceViewModel()
    @State private var isMe = 0
    var body: some View {
        VStack{
            Text(LocalizedStringKey("hr_clearance"))
                .font(.system(size: 20))
                .foregroundColor(.rinoBrown)
                .fontWeight(.bold)
                .padding(.vertical,5)
            
            FiltersView(englishFilters:Constents.filtersDict,arabicFilters: Constents.filters,selectedFilter: $selectedFliter.onChange(filterDidChange), selectedArabicFilter: $selectedArabic)
            if viewModel.errorcase != .none{
                ErrorView(action: {
                    viewModel.fetchData()
                }, errorcase: viewModel.errorcase)
            }
            if viewModel.errorcase == .none{
                ZStack{
                    List{
                        ForEach(viewModel.data.data ?? []){ item in
                            Section{
                                HRHomeCell(item: item, isMe: viewModel.isME)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                        if viewModel.isLoading{
                            HomePaymentCell(item: PPData(), isMe: false)
                                .skeleton(with: viewModel.isLoading)
                                .shape(type: .rectangle)
                                .frame(height:200)
                        }
                        
                        
                    } .introspectTableView { tableView in
                        tableView.separatorColor = .clear
                        tableView.backgroundView = nil
                        tableView.backgroundColor = nil
                        tableView.showsVerticalScrollIndicator = false
                        
                        let control = UIRefreshControl()
                        
                        refreshHelper.parent = self
                        refreshHelper.refreshControl = control
                        
                        control.addTarget(refreshHelper, action: #selector(RefreshHelper.didRefresh), for: .valueChanged)
                        tableView.refreshControl = control
                    }
                    .padding(.top,20)
                    .padding(.horizontal,15)
                }
                .background(
                    Rectangle()
                        .fill(Color.listBackground)
                        .cornerRadius(50, corners: [.topLeft, .topRight])
                )
                .padding(.top,10)
            }
            HStack{
                Button {
                    viewModel.destination = "me"
                    viewModel.isME.toggle()
                    viewModel.fetchData()
                } label: {
                    TabBarItem(imageName: "doc.plaintext.fill", buttonName: LocalizedStringKey("me"), color: viewModel.isME ? Color.orange:Color.gray   ,edgeSet: .leading)
                }
                .padding(.vertical,8)
                Spacer()
                Button {
                    viewModel.destination = "others"
                    viewModel.isME.toggle()
                    viewModel.fetchData()
                } label: {
                    TabBarItem(imageName: "arrowshape.turn.up.backward.2.fill", buttonName: LocalizedStringKey("other"), color: self.viewModel.isME ? Color.gray : Color.orange  ,edgeSet: .trailing)
                }
            }
            
            .navigationBarItems(trailing:
                                    
                                    HStack{
                NavigationLink(destination: HRSearchView()) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.rinoBrown)
                }
                NavigationLink(destination: NotificationsView()) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(Color.rinoBrown)
                        .overlay(Badge(count: $viewModel.counter))
                }
                
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.rinoBrown)
                }
            }
            )
            .environment(\.layoutDirection, .rightToLeft)
            .onAppear{
                if viewModel.data.data?.isEmpty == true || viewModel.data.data == nil {
                    viewModel.fetchData()
                }
            }
            
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func filterDidChange(str:String){
        viewModel.duration = str
        viewModel.fetchData()
    }
    
    class RefreshHelper {
        var parent: HRHomePage?
        var refreshControl: UIRefreshControl?
        
        @objc func didRefresh() {
            guard let parent = parent, let refreshControl = refreshControl else { return }
            parent.viewModel.fetchData()
            
            refreshControl.endRefreshing()
        }
    }
}

struct HRHomePage_Previews: PreviewProvider {
    static var previews: some View {
        HRHomePage()
    }
}
