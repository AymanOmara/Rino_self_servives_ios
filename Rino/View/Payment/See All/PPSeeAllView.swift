//
//  PPSeeAll.swift
//  Rino
//
//  Created by Ayman Omara on 23/06/2022.
//

import SwiftUI
import SkeletonUI
import Introspect
struct PPSeeAllView: View {
    var startDate,endDate:String
    var isForwordToMe:Bool
    
    
    @ObservedObject var viewModel = SeeAllViewModel()
    
    var body: some View {
        List{
            ForEach(viewModel.items){ item in
                
                Section{
                    PPSeeAllCard(item: item, isForwordToMe: isForwordToMe)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .onAppear {
                            
                            if viewModel.items.last?.id == item.id && !viewModel.isshowLoading && viewModel.currentPageNumber < viewModel.pagesAmount{
                                viewModel.currentPageNumber += 1
                                viewModel.fetchData()
                            }
                        }
                        .background(
                            NavigationLink(destination: PPDetailsView(id: item.id!, isForwordToMe: isForwordToMe), label: {
                                EmptyView()
                            }).opacity(0)
                            
                        )
                }
            }
            if viewModel.items.isEmpty && !viewModel.errorMessage.isEmpty{
                ErrorView(action: {
                    viewModel.fetchData()
                }, errorcase: viewModel.errorcase)
            }
            if viewModel.isshowLoading{
                PPSeeAllCard(item: PaymentItem(), isForwordToMe: false)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    .skeleton(with: viewModel.isshowLoading)
                    .shape(type: .rectangle)
                    .frame(height:200)
            }
            if !viewModel.items.isEmpty && !viewModel.errorMessage.isEmpty{
                HStack{
                    Text(viewModel.errorMessage)
                    Button {
                        viewModel.fetchData()
                    } label: {
                        Text(NetworkErrorCase.timeOut.rawValue)
                    }
                }
            }
        }.onAppear{
            if viewModel.items.isEmpty == true{
                self.viewModel.startDate = startDate
                self.viewModel.endDate = endDate
                if isForwordToMe{
                    viewModel.destination = "me"
                }else{
                    viewModel.destination = "others"
                }
                viewModel.fetchData()
            }
        }
        .introspectTableView(customize: { tableView in
            tableView.separatorColor = .clear

        })


        .environment(\.layoutDirection, .rightToLeft)

    }
}

struct PPSeeAll_Previews: PreviewProvider {
    static var previews: some View {
        PPSeeAllView(startDate: "", endDate: "", isForwordToMe: false)
    }
}

struct Columen:View{
    var key:String
    var value:String?
    var body: some View{
        VStack(alignment:.leading){
            Text(key)
                .fontWeight(.semibold)
                .padding(.top,5)
            Text(value != nil ? value! :Constents.noValue)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
struct RequestState:View{
    var key:String
    var value:String?
    var valueColor:Color
    var body: some View{
        HStack{
            Text(key)
                .fontWeight(.semibold)
                .padding(.trailing,13)
            Text(value != nil ? value! : Constents.noValue)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: true, vertical: false)
                .padding(3)
                .background(valueColor)
                .cornerRadius(6)
        }
    }
}

struct Container:View{
    var color:Color
    var text:String?
    var body: some View{
        Text(text != nil ? text! : Constents.noValue)
            .padding(6)
            .background(color)
            .cornerRadius(6)
    }
}
