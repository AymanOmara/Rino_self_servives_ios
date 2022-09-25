//
//  HRSeeAll.swift
//  Rino
//
//  Created by Ayman Omara on 04/07/2022.
//

import SwiftUI
import SkeletonUI
import SPAlert
struct HRSeeAll: View {
    @ObservedObject var viewModel = ClearanceSeeAllViewModel()
    var start,end:String
    var isFromME:Bool
    var body: some View {
        
        VStack {
            if viewModel.errorcase == .none {
                List {
                    ForEach(viewModel.data){ item in
                        Section{
                            HRSeeAllCell(item: item, isFromMe: isFromME)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                .onAppear {
                                    
                                    if viewModel.data.last?.id == item.id && !viewModel.isLodaing && viewModel.currentPageNumber < viewModel.pagesAmount{
                                        viewModel.currentPageNumber += 1
                                        viewModel.fetchData()
                                    }
                                }
                                .background(
                                    
                                    NavigationLink(destination: HRDetailsView(id:item.id ?? 0,isForwordToMe: isFromME,entity: item.entity ?? 0), label: {
                                        EmptyView()
                                    }).opacity(0)
                                )
                        }
                    }
                    if viewModel.isLodaing{
                        PPSeeAllCard(item: PaymentItem(), isForwordToMe: isFromME)
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        
                            .skeleton(with: viewModel.isLodaing)
                            .shape(type: .rectangle)
                            .frame(height:200)
                    }
                    if !viewModel.errormessage.isEmpty{
                        HStack{
                            Text(viewModel.errormessage)
                            Button {
                                viewModel.fetchData()
                            } label: {
                                Text("اعاده المحاولة")
                                    .padding(5)
                                    .background(Color.orange)
                            }
                        }
                    }
                    
                }
                .padding(.top,10)
                .onAppear{
                    
                    viewModel.date = (self.start,self.end)
                    if isFromME{
                        viewModel.destination = "me"
                    }else{
                        viewModel.destination = "others"
                    }
                    viewModel.fetchData()
                }
                .environment(\.layoutDirection, .rightToLeft)
            } else {
                ErrorView(action: {
                    viewModel.fetchData()
                }, errorcase: viewModel.errorcase)
            }
        }
    }
}

struct HRSeeAll_Previews: PreviewProvider {
    static var previews: some View {
        HRSeeAll(start: "", end: "", isFromME: false)
    }
}
