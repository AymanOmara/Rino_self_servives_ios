//
//  HRSearchView.swift
//  Rino
//
//  Created by Ayman Omara on 05/07/2022.
//

import SwiftUI
import SkeletonUI
import SPAlert
struct HRSearchView: View {
    
    @ObservedObject var viewModel = HRSearchViewModel()
    @State var text = ""
    @State var isEditing = false
    var body: some View {
        VStack{
            SearchBar(text: $text, isEditing: $isEditing, onSbmit: {
                viewModel.currentPageIndex = 1
                viewModel.serachedText = text
                viewModel.getSearchedItems()
                
            })
            
            .padding(.top,5)
            if viewModel.errorcase == .none{
                List{
                    ForEach(viewModel.data){ item in
                        HRSearchCell(item: item, isFromMe: item.me ?? false)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .onAppear {
                                
                                if viewModel.data.last?.id == item.id && !viewModel.isLoading && viewModel.currentPageIndex < viewModel.totalPagesNumber{
                                    viewModel.currentPageIndex += 1
                                    viewModel.getSearchedItems()
                                }
                            }
                            .background(
                                
                                NavigationLink(destination: HRDetailsView(id:item.id ?? 0,isForwordToMe: item.me ?? false,entity: item.entity ?? 0), label: {
                                    EmptyView()
                                }).opacity(0)
                                
                            )
                    }
                    if viewModel.isLoading{
                        HRSearchCell(item: HRSearchData(), isFromMe: false)
                            .skeleton(with:viewModel.isLoading)
                            .shape(type: .rectangle)
                            .frame(height:200)
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
            
            
            
            Spacer()
        }
        .SPAlert(isPresent: $viewModel.showMessage, alertView: SPAlertView(title: viewModel.alert?.title ?? "", message: viewModel.alert?.body ?? "", preset: viewModel.alert?.alertCase ?? .done))
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct HRSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HRSearchView()
    }
}
struct SearchBar:View{
    @Binding var text:String
    @Binding var isEditing:Bool
    var onSbmit:(()->())
    var body: some View{
        HStack{
            TextField("البحث",text: $text){
                onSbmit()
                
                UIApplication.shared.endEditing()
            }
            .padding(7)
            .padding(.horizontal, 25)
            . background (Color(. systemGray6))
            .cornerRadius(8)
            
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if isEditing {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture{
                self.isEditing = true
            }
            if isEditing{
                Button {
                    onSbmit()
                    UIApplication.shared.endEditing()
                    isEditing = false
                } label: {
                    Text("ابحث")
                }
                .padding(.trailing,10)
                .transition(.move (edge:.trailing))
                .animation(.default)
                
            }
        }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
