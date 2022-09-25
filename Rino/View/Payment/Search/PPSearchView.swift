//
//  PPSearchView.swift
//  Rino
//
//  Created by Ayman Omara on 18/07/2022.
//

import SwiftUI
import SkeletonUI
import Introspect
struct PPSearchView: View {
    @ObservedObject var viewModel = PPSearchViewModel()
    @State var text = ""
    @State var isEditing = false
    var body: some View {
        VStack{
            SearchBar(text: $text, isEditing: $isEditing, onSbmit: {
                viewModel.getData(text: text)
            })
            .padding(.top,5)
            if viewModel.errorcase == .none{
                List{
                    ForEach(viewModel.items){ item in
                        Section{
                            PPSeeAllCard(item: item, isForwordToMe: item.me ?? false)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .background(
                                    NavigationLink(destination: PPDetailsView(id: item.id ?? 0, isForwordToMe: item.me ?? false), label: {
                                        EmptyView()
                                    }).opacity(0)
                                )
                        }
                    }
                    if viewModel.isLoading{
                        PPSeeAllCard(item: PaymentItem(), isForwordToMe: false)
                            .skeleton(with: viewModel.isLoading)
                            .shape(type: .rectangle)
                            .frame(height:200)
                    }
                }.introspectTableView { tableView in
                    tableView.separatorColor = .clear
                }
            }else{
                ScrollView{
                    ErrorView(action: {
                    
                    }, errorcase: viewModel.errorcase)
                }
            }

        }
    }
}

struct PPSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PPSearchView()
    }
}
