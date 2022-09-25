//
//  CompliantsView.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import SwiftUI
import Combine
import SkeletonUI
struct CompliantsView: View {
    @State var isActive:Bool = false

    @ObservedObject var viewModel = ViewCompliantsViewModel()
    
    var body: some View {

        if viewModel.hasePerssion == true{
            if viewModel.errorcase != .none{
                ErrorView(action: {
                    if viewModel.hasePerssion != nil && viewModel.hasePerssion == true{
                        viewModel.getAllCompliants()
                    }else if viewModel.hasePerssion == nil{
                        viewModel.getPersissionState()
                    }
                }, errorcase: viewModel.errorcase)
            }
            else{
                List{
                    ForEach(viewModel.complians){ complain in
                        Section{
                            CompliantsCard(complain: complain)
                        }
                    }
                }
                .onAppear{
                    if viewModel.hasePerssion! && viewModel.complians.isEmpty{
                        viewModel.getAllCompliants()
                    }
                }
                
                .environment(\.layoutDirection, .rightToLeft)
                .floatingActionButton(color: .orange, image:
                                        
                                        Image(systemName: "plus")
                                      
                                      , action: {
                    isActive = true
                })
                
                .background(NavigationLink(destination: CreateNewCompliants(),isActive: $isActive, label: {
                    EmptyView()
                }))
                
                
                .environment(\.layoutDirection, .leftToRight)
                .skeleton(with: viewModel.isLoading)
                .shape(type: .rectangle)
            }
            
            
        }else if viewModel.hasePerssion == false{
            CreateNewCompliants()
        } else if viewModel.hasePerssion == nil {
            if viewModel.errorcase != .none{
                ErrorView(action: {
                    if viewModel.hasePerssion != nil && viewModel.hasePerssion == true{
                        viewModel.getAllCompliants()
                    }else if viewModel.hasePerssion == nil{
                        viewModel.getPersissionState()
                    }
                }, errorcase: viewModel.errorcase)
            }
            ZStack{
                
            }.onAppear{
                viewModel.getPersissionState()
            }
            .skeleton(with: viewModel.isLoading)
            .shape(type: .rectangle)
        }
        
    }
    
}

struct CompliantsView_Previews: PreviewProvider {
    static var previews: some View {
        CompliantsView()
    }
}

struct CompliantsCard:View{
    var complain:Complian
    @State var isActive = false
    var body: some View{
        
        VStack(alignment:.leading){
            RowData(key: "التاريخ", value: complain.createdAt.components(separatedBy: "T")[0].toArabicDate())
            RowData(key: "الادارة", value: complain.department)
            RowData(key: "المسؤل", value: complain.officer)
            RowData(key: "الوصف", value: complain.body)
        }
        Button {
            isActive = true
        } label: {
            Text("عرض المرفقات")
                .frame(width:UIScreen.main.bounds.width-100,height: 50)
                .padding(.horizontal,20)
                .background(Color.orange)
                .cornerRadius(10)
                .foregroundColor(.white)
            
        }.background(
            NavigationLink(isActive: $isActive, destination: {
                ComplaintAttachmentList(attachments: complain.attchements ?? [])
            }, label: {
                EmptyView()
            })
        )
    }
}
struct RowData:View{
    var key,value:String
    var body: some View{
        HStack(alignment:.top){
            Text(key)
                .fontWeight(.semibold)
            Text(value)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
        }
    }
}
struct FloatingActionButton<ImageView: View>: ViewModifier {
    let color: Color // background color of the FAB
    let image: ImageView // image shown in the FAB
    let action: () -> Void
    
    private let size: CGFloat = 60 // size of the FAB circle
    private let margin: CGFloat = 10 // distance from screen edges
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            ZStack {
                Color.clear // allows the ZStack to fill the entire screen
                content
                button(geo)
            }
            
        }
    }
    
    @ViewBuilder private func button(_ geo: GeometryProxy) -> some View {
        image
            .imageScale(.large)
            .frame(width: size, height: size)
            .background(Circle().fill(color))
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
            .onTapGesture(perform: action)
            .offset(x: (geo.size.width - size) / 2 - margin,
                    y: (geo.size.height - size) / 2 - margin)
    }
}
extension View {
    func floatingActionButton<ImageView: View>(
        color: Color,
        image: ImageView,
        action: @escaping () -> Void) -> some View {
            self.modifier(FloatingActionButton(color: color,
                                               image: image,
                                               action: action))
        }
}
struct ComplaintAttachmentList:View{
    var attachments :[ComplianAttachments]
    var body: some View{
        if  attachments.isEmpty{
            LottieView(fileName: "emptydata")
                .frame(width:300,height: 400)
            Text("لا يوجد مرفقات لعرضها")
            
        }else{
            List{
                
                ForEach(attachments){ item in
                    ComplaintAttachmentCell(attachment: item)
                    
                }
            }
        }
    }
}
struct ComplaintAttachmentCell:View{
    var attachment:ComplianAttachments
    var body: some View{
        HStack{
            Image(systemName: "personalhotspot")
                .resizable()
                .frame(width:40,height: 40)
            Text(attachment.name ?? Constents.noValue)
        }  .onTapGesture {
            UIApplication.shared.open(URL(string: attachment.url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
        }
    }
}
