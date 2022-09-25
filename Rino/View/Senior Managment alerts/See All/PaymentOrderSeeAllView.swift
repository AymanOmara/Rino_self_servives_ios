//
//  PaymentOrderSeeAllView.swift
//  Rino
//
//  Created by Ayman Omara on 14/08/2022.
//

import SwiftUI
import Introspect
import SkeletonUI
struct PaymentOrderSeeAllView: View {
    var start,end:String
    var currentPageIndex:Int
    @ObservedObject private var viewModel = PaymentOrderSeeAllViewModel()
    var body: some View {
        VStack{
            if  viewModel.errorcase == .none {
                List{
                    ForEach(viewModel.items){ item in
                        Section{
                            PaymentOrderItemCard(request: item)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .onAppear {
                                    if viewModel.items.last?.id == item.id && !viewModel.isLoading && viewModel.currentPageNumber < viewModel.pagesAmount{
                                        viewModel.currentPageNumber += 1
                                        viewModel.fetchData()
                                    }
                                }
                        }
                    }
                    if viewModel.isLoading{
                        PaymentOrderItemCard(request: PaymentOrderItem())
                            .skeleton(with: viewModel.isLoading)
                            .shape(type: .rectangle)
                            .frame(height:200)
                        
                    }
                }
            }else{
                ErrorView(action: {
                    viewModel.fetchData()
                }, errorcase: viewModel.errorcase)
            }
        }.onAppear{
            viewModel.endDate = end
            viewModel.startDate = start
            viewModel.currentPageNumber = 1
            viewModel.fetchData()
        }
    }
}

struct PaymentOrderSeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOrderSeeAllView(start: "", end: "", currentPageIndex: 1)
    }
}
