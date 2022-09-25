//
//  PaymentProcessView.swift
//  Rino
//
//  Created by Ayman Omara on 12/07/2022.
//

import SwiftUI
import Combine
import SkeletonUI
import Introspect
struct PaymentProcessView: View {
    @State var selectedFliter = "all"
    @State var selectedArabic = "الكل"
    
    @ObservedObject var viewModel = PaymentViewModel()
    @State private var isMe = 0
    @State var counter = 0
    let refreshHelper = RefreshHelper()
    
    var body: some View {
        ZStack(alignment:.top){
            VStack{
                Text(LocalizedStringKey("payment_process"))
                    .font(.system(size: 20))
                    .foregroundColor(.rinoBrown)
                    .fontWeight(.bold)
                    .padding(.vertical,5)
                
                FiltersView(englishFilters:Constents.filtersDict,arabicFilters: Constents.filters,selectedFilter: $selectedFliter.onChange(filterDidChange), selectedArabicFilter: $selectedArabic)
                if viewModel.errorcase != .none{
                    ErrorView(action: {
                        viewModel.getPayments()
                    }, errorcase: viewModel.errorcase)
                }
                if viewModel.errorcase == .none{
                    ZStack{
                        List{
                            ForEach(viewModel.payments.data ?? []){ item in
                                Section{
                                    HomePaymentCell(item: item, isMe:viewModel.isMe)
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
                        viewModel.distination = "me"
                        viewModel.isMe.toggle()
                        viewModel.getPayments()
                    } label: {
                        TabBarItem(imageName: "doc.plaintext.fill", buttonName: LocalizedStringKey("me"), color: viewModel.isMe ? Color.orange: Color.gray  , edgeSet:.leading)
                    }
                    .padding(.vertical,8)
                    Spacer()
                    Button {
                        viewModel.distination = "others"
                        viewModel.isMe.toggle()
                        viewModel.getPayments()
                    } label: {
                        TabBarItem(imageName: "arrowshape.turn.up.backward.2.fill", buttonName: LocalizedStringKey("other"), color: viewModel.isMe ? Color.gray : Color.orange  ,edgeSet: .trailing)
                        
                    }
                }
                
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(UIColor.systemBackground))
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        
        .navigationBarItems(trailing:
                                
                                HStack{
            NavigationLink(destination: PPSearchView()) {
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
            if viewModel.payments.data?.isEmpty == true || viewModel.payments.data == nil {
                viewModel.getPayments()
            }
        }
    }
    class RefreshHelper {
        var parent: PaymentProcessView?
        var refreshControl: UIRefreshControl?
        
        @objc func didRefresh() {
            guard let parent = parent, let refreshControl = refreshControl else { return }
            parent.viewModel.getPayments()
            
            refreshControl.endRefreshing()
        }
    }
    
    func filterDidChange(str:String){
        viewModel.selectedFilter = str
        viewModel.getPayments()
    }
    
}

struct PaymentProcessView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentProcessView()
    }
}


struct Badge: View {
    @Binding var count:Int
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count).toArabicNumber())
                .foregroundColor(count == 0 ? Color.clear : .white)
                .font(.system(size: 10))
                .padding(4)
                .background(count == 0 ? Color.clear : Color.red)
                .clipShape(Circle())
                .alignmentGuide(.top) { $0[.bottom] }
                .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
            })
    }
}
