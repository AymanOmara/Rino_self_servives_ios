//
//  HRDetails.swift
//  Rino
//
//  Created by Ayman Omara on 03/07/2022.
//

import SwiftUI
import SPAlert
import SkeletonUI
import Combine

struct HRDetailsView: View {
    @State var showAttachmentPicker = false
    @State var showAttchmentChosser = false
    
    @State private var attchmentType = AttachmentType.none
    @State var viewHeight:CGFloat = 90
    var id:Int
    var isForwordToMe:Bool
    var entity:Int
    @State var documents = [UploadableFile]()
    @State private var showPicker = false
    @ObservedObject var viewModel = HRDetailsViewModel()
    var body: some View {
        ZStack {
            if viewModel.errorcase == .none{
                ZStack {
                VStack {
                    if isForwordToMe{
                        HStack{
                            Spacer()
                            NavigationLink(destination: ChosenAttachmentsView( chosenAttachments: $documents), label: {
                                Text("عرض المرفقات المختارة")
                                    .foregroundColor(Color.white)
                                    .padding(3)
                                    .background(Color.orange)
                                    .cornerRadius(3)
                            })

                            Button {
                                viewModel.createAttachments(attatchments: documents)
                            } label: {
                                Text("تاكيد المرفقات")
                                    .foregroundColor(Color.white)
                                    .padding(3)
                                    .background(Color.orange)
                                    .cornerRadius(3)
                            }

                        }.padding(.trailing,20)
                    }
                    HStack(alignment:.top){
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment:.leading){
                                HRDetailsCell(item: viewModel.data, isForwordMe: isForwordToMe, showAttchmentPicker: $showAttchmentChosser, viewModel: viewModel)
                                Spacer()
                            }
                        }
                        
                        .background(RoundedRectangle(cornerRadius: 3, style: .continuous).fill(Color(UIColor.systemBackground)))
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 0)
                        
                        
                        .padding(.horizontal,5)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: viewHeight)
                        
                        
                        VStack{
                            Image("\(viewModel.data.data?.step ?? 1)_7")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(height: ( viewHeight))
                    }
                    if isForwordToMe && viewModel.data.data?.hasPermission == true && viewModel.data.data?.hasApprovedRequest == false && viewModel.shouldEnableApprovel{
                        Button {
                            viewModel.approveOrDeny(approvalState: "approve")
                            
                        } label: {
                            Text(viewModel.data.data?.current?.name ?? Constents.noValue)
                                .frame(width: UIScreen.main.bounds.width-20, height:30)
                                .background(Color.orange)
                                .cornerRadius(6)
                        }.padding(.bottom,10)

                        if viewModel.data.data?.status?.contains("جديد") == true{
                            Button {
                                viewModel.approveOrDeny(approvalState: "deny")
                            } label: {
                                Text("رفض")
                                    .frame(width: UIScreen.main.bounds.width-20, height:30)
                                    .background(Color.orange)
                                    .cornerRadius(6)
                            }
                        }
                    }
                    
                    
                    Spacer()
                }
                .onAppear{
    //                if isForwordToMe && viewModel.data.data != nil{
                        viewHeight = UIScreen.main.bounds.height * 0.7
    //                }else if !isForwordToMe && viewModel.data.data != nil{
    //                    viewHeight = UIScreen.main.bounds.height * 0.83
    //                }
                }
                .skeleton(with: viewModel.isLoading)
                .shape(type: .rectangle)
                .padding(.vertical,10)
                Spacer()
                
            }

            
            .onAppear{
                if viewModel.data.data == nil{
                    viewModel.isLoading = true
                    viewModel.id = id
                    viewModel.entity = entity
                    viewModel.fetchData()
                }
            }
            .actionSheet(isPresented: $showAttchmentChosser, content: {
                ActionSheet(title: Text("قم باختيار مكان المرفق"),
                            buttons: [
                                .default(Text("الاستيديو")) {
                                    self.attchmentType = .gallery
                                    showAttachmentPicker = true
                                },
                                .default(Text("الكاميرا")) {
                                    self.attchmentType = .camera
                                    showAttachmentPicker = true
                                },
                                .default(Text("ملفات")) {
                                    self.attchmentType = .doucments
                                    showAttachmentPicker = true
                                },
                                .cancel()
                            ])
            })
            .sheet(isPresented: $showAttachmentPicker){
                
                if attchmentType == .gallery{
                    if #available(iOS 14, *) {
                        GallaryView(documents: $documents)
                    }else{
                        //FALL Back
                    }
                }else if attchmentType == .camera{
                    CameraView(documents: $documents)
                }else if attchmentType == .doucments{
                    DocumentsView(documents: $documents)
                }
            }
//            .sheet(isPresented: $showPicker){
//                DocumentsView(documents: $documents)
//            }
//            .onReceive(Just(documents)) { value in
//                if !value.isEmpty{
//                    viewModel.createAttachments(attatchments: documents)
//                    documents.removeAll()
//                }
//            }
            .SPAlert(isPresent: $viewModel.showAlert, alertView: SPAlertView(title: viewModel.alert?.title ?? "", message: viewModel.alert?.body ?? "", preset: viewModel.alert?.alertCase ?? .done))
        .environment(\.layoutDirection, .rightToLeft)
            } else {
                ErrorView(action: viewModel.fetchData, errorcase: viewModel.errorcase)
            }
        }.navigationBarTitle("", displayMode: .inline)
    }
    
}

struct HRDetails_Previews: PreviewProvider {
    static var previews: some View {
        HRDetailsView(id: 50, isForwordToMe: true,entity: 0)
    }
}
struct HRDetailsCell:View{
    var item:HRDetailsResponse
    var isForwordMe:Bool
    @Binding var showAttchmentPicker:Bool
    @ObservedObject var viewModel:HRDetailsViewModel
    var body: some View{
        VStack(alignment:.leading){
            FirstSection(idTitle: "رقم المخالصة", id: item.data?.id != nil ? String(item.data!.id!).toArabicNumber() : Constents.noValue, dateTitle: "تاريخ الطلب", date: item.data?.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
            RequestState(key: "حالة الاجراء", value: item.data?.status ?? Constents.noValue, valueColor: isForwordMe ? Color.orange : Color.gray)
            Divider()
            Columen(key: "الوصف", value: item.data?.current?.name ?? Constents.noValue)
            HRDetailsThirdSection(item: item)
            RequestState(key: "محال الى", value: item.data?.current?.users?.isEmpty == true ? Constents.noValue :item.data?.current?.users?[0], valueColor:  .orange)
            Divider()
            Columen(key: "نوع المخالصة", value: item.data?.type)
            VacationView(type: item.data?.type ?? Constents.noValue, start: item.data?.start ?? "", end: item.data?.end ?? "")
            HRAttachmentSection(isForwordToMe: isForwordMe, showAttchmentPicker: $showAttchmentPicker, viewModel: viewModel)
        }
        .padding(.horizontal,10)
    }
}
struct HRAttachmentSection:View{
    var isForwordToMe:Bool
    @Binding var showAttchmentPicker:Bool
    @ObservedObject var viewModel:HRDetailsViewModel
    var body: some View{
        VStack(alignment:.leading){
            Divider()
            
            Text("المرفقات")
                .fontWeight(.bold)
                .padding(.bottom,10)
            HStack{
                
                NavigationLink(destination: AttachmentsView(attachments: viewModel.attachments)) {
                    Text("عرض المرفقات")
                        .frame(width: isForwordToMe ? UIScreen.main.bounds.width * 0.3:UIScreen.main.bounds.width * 0.7,height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("brown"), lineWidth: 5)
                        )
                }
                Spacer()
                if isForwordToMe{
                    Button {
                        showAttchmentPicker.toggle()
                    } label: {
                        Text("اضافة مرفقات")
                            .frame(width: UIScreen.main.bounds.width * 0.3,height: 50)
                        
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("brown"), lineWidth: 5)
                            )
                    }
                }
                
            }
            
        }
        .padding(.horizontal,10)
    }
}
struct HRDetailsThirdSection:View{
    var item:HRDetailsResponse
    var body: some View{
        VStack(alignment:.leading){
            Columen(key: "رقم الموظف", value: item.data?.employee_id != nil ? String(item.data!.employee_id!).toArabicNumber() : Constents.noValue)
            Columen(key: "اسم الموظف", value: item.data?.employee)
            Columen(key: "الادارة", value: item.data?.department)
            Divider()
        }
    }
}
struct VacationView:View{
    var type,start,end:String
    var body: some View{
        if type.contains("خروج وعودة") == true{
            RowData(key: "بداية الاجازة", value: start.components(separatedBy: "T")[0].toArabicDate() )
                .padding(.vertical,5)
            RowData(key: "نهاية الاجازة", value: end.components(separatedBy: "T")[0].toArabicDate())
                .padding(.vertical,5)
        }
    }
}
