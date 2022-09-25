//
//  PaymentOrderSearch.swift
//  Rino
//
//  Created by Ayman Omara on 14/08/2022.
//

import SwiftUI
import SPAlert
import SkeletonUI
struct PaymentOrderSearchView: View {
    @State var text = ""
    @State var isEditing = false
    @ObservedObject private var viewModel = PaymentOrderSearchViewModel()
    var body: some View {

        SearchBar(text: $text, isEditing: $isEditing, onSbmit: {
            viewModel.currentPageIndex = 1
            viewModel.serachedText = text
            viewModel.getSearchedItems()
        })
        .padding(.top,5)
        VStack{
            if viewModel.errorcase == .none{
                List{
                    ForEach(viewModel.data){ item in
                        Section{
                            PaymentOrderItemCard(request: item)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .onAppear {
                                    
                                    if viewModel.data.last?.id == item.id && !viewModel.isLoading && viewModel.currentPageIndex < viewModel.totalPagesNumber{
                                        viewModel.currentPageIndex += 1
                                        viewModel.getSearchedItems()
                                    }
                                }
                        }
                    }
                    if viewModel.isLoading{
                        Section{
                            HRSearchCell(item: HRSearchData(), isFromMe: false)
                                .skeleton(with:viewModel.isLoading)
                                .shape(type: .rectangle)
                                .frame(height:200)
                        }
                    }
                }
                .gesture(DragGesture().onChanged{_ in
                    UIApplication.shared.endEditing()})
                .padding(.vertical,10)
                
            }else{
                ScrollView{
                    ErrorView(action: {
                        viewModel.getSearchedItems()
                    }, errorcase: viewModel.errorcase)
                }

            }
        }  .onDisappear{
            viewModel.resetToInitState()
        }
        .SPAlert(isPresent: $viewModel.showMessage, alertView: SPAlertView(title: viewModel.alert?.title ?? "", message: viewModel.alert?.body ?? "", preset: viewModel.alert?.alertCase ?? .done))
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct PaymentOrderSearch_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOrderSearchView()
    }
}
