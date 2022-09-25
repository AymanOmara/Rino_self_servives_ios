//
//  PPDetailsView.swift
//  Rino
//
//  Created by Ayman Omara on 22/06/2022.
//

import SwiftUI
import Combine
import SPAlert
import SkeletonUI
struct PPDetailsView: View {
    var id:Int
    var isForwordToMe:Bool
    
    @State var showAttachmentPicker = false
    @State var showAttchmentChosser = false
    @State var showEditAmount = false
    @State private var showPicker = false
    
    @State private var attchmentType = AttachmentType.none
    @State var changeAmount = ChangeAmount()
    @State var viewHeight:CGFloat = 90
    
    @ObservedObject var viewModel = PaymentDetailsViewModel()
    
    @State var documents = [UploadableFile]()
    var body: some View {
        VStack {
            if viewModel.error.isEmpty && viewModel.errorcase == .none {
                ZStack{
                ZStack{
                    VStack{
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
                                    DetailsFirstSection(viewModel: viewModel)
                                        .foregroundColor(Color(UIColor.label))
                                    DetailsSecondSection(isForwordToMe: isForwordToMe,viewModel: viewModel)
                                    
                                        .foregroundColor(Color(UIColor.label))
                                    RequestState(key: "محال الى", value: viewModel.data.data?.current?.users?.isEmpty == true ? Constents.noValue :viewModel.data.data?.current?.users?[0], valueColor:  .orange)
                                        .padding(.leading,10)
                                    Divider()
                                    DetailsTheridSection(viewModel: viewModel, showEditAmount: $showEditAmount)
                                        .foregroundColor(Color(UIColor.label))
                                    DetailsAttachmentSection(isForwordToMe: isForwordToMe, showAttchmentPicker: $showAttchmentChosser, viewModel: viewModel)
                                        .foregroundColor(Color(UIColor.label))
                                    Spacer()
                                }
                            }
                            
                            .background(RoundedRectangle(cornerRadius: 3, style: .continuous)
                                .fill(Color(UIColor.systemBackground)))
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
                        if isForwordToMe && viewModel.data.data?.hasPermission == true && viewModel.data.data?.hasMadeAction == false && viewModel.shouldEnableApprovel{
                            Button {
                                viewModel.approveOrDeny(approvalState: "approve")
                            } label: {
                                Text(viewModel.data.data?.current?.name ?? Constents.noValue)
                                    .frame(width: UIScreen.main.bounds.width-20, height:35)
                                    .background(Color.orange)
                                    .cornerRadius(6)
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom,10)
                            if viewModel.data.data?.status?.contains("جديد") == true{
                                Button {
                                    viewModel.approveOrDeny(approvalState: "deny")
                                } label: {
                                    Text("رفض")
                                        .frame(width: UIScreen.main.bounds.width-20, height:35)
                                        .background(Color.orange)
                                        .cornerRadius(6)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical,10)
                    Spacer()
                        .onAppear{
                            if isForwordToMe{
                                viewHeight = UIScreen.main.bounds.height * 0.7
                            }else{
                                viewHeight = UIScreen.main.bounds.height * 0.83
                            }
                        }
                    
                        .navigationBarItems(trailing:
                                                
                        NavigationLink(destination: {
                            ArchiveMovementModificationsView(id: id)
                        }, label: {
                            if viewModel.isGM{
                                Text("ارشيف حركه التعديلات")
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            
                        })
                        )
                }
                .opacity(viewModel.data.data?.id == nil ? 0 : 1)
                .gesture(DragGesture().onChanged{_ in
                    showEditAmount = false
                    })

                
                
                if showEditAmount{
                    EditAmountView(isShown: $showEditAmount, changeAmount: $changeAmount, oldAmount: viewModel.data.data?.amount ?? 0 )
                        .environment(\.layoutDirection, .rightToLeft)
                    
                }
            }.navigationBarTitle("", displayMode: .inline)
//            .sheet(isPresented: $showPicker){
//                DocumentsView(documents: $documents)
//            }
            .SPAlert(isPresent: $viewModel.showAlert, alertView: SPAlertView(title: viewModel.alert?.title ?? "", message: viewModel.alert?.body ?? "", preset: viewModel.alert?.alertCase ?? .done))
            
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
            .onReceive(Just(changeAmount)) { value in
                if let shouldChangeAmount = value.shouldChangeAmount{
                    if shouldChangeAmount{
                        viewModel.editAmount(newAmount: value.newAmount!)
                        changeAmount = ChangeAmount(newAmount: 0, shouldChangeAmount: false)
                    }
                }
                
            }
            .skeleton(with: viewModel.isLoading)
            .shape(type: .rectangle)
            
            
            .environment(\.layoutDirection, .rightToLeft)
            .onAppear{
                if viewModel.data.data == nil {
                    viewModel.id = id
                    viewModel.fetchData()
                }
        }
            } else {
                ErrorView(action: {
                    viewModel.fetchData()
                }, errorcase: viewModel.errorcase)
            }
        }
    }
    
}

struct PPDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PPDetailsView(id:5, isForwordToMe: false)
    }
}
struct ColumenDetails:View{
    var key,value:String
    var body: some View{
        VStack(alignment:.leading){
            Text(key)
                .fontWeight(.semibold)
                .foregroundColor(Color(UIColor.label))
            Text(value)
                .foregroundColor(Color(UIColor.label))
                .padding(.top,5)
            
        }
        .padding(.top,10)
        .padding(.horizontal,10)
    }
    
}
struct DetailsFirstSection:View{
    @ObservedObject var viewModel:PaymentDetailsViewModel
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("رقم الطلب")
                    .background(Color.clear)
                Spacer()
                Text("تاريخ الطلب")
                    .background(Color.clear)
            }
            HStack{
                Text(String(viewModel.data.data?.id ?? 0).toArabicNumber())
                    .padding(.top,5)
                Spacer()
                Text(viewModel.data.data?.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
                    .padding(.top,5)
            }
            Divider()
        }
        .padding(.vertical,5)
        .padding(.horizontal,10)
        
    }
}
struct DetailsSecondSection:View{
    var isForwordToMe: Bool
    @ObservedObject var viewModel:PaymentDetailsViewModel
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("حالة الطلب")
                    .padding(.leading,10)
                Text(viewModel.data.data?.status ?? Constents.noValue)
                    .padding(6)
                    .background(isForwordToMe ? Color.orange : Color.gray)
                    .cornerRadius(10)
            }
            ColumenDetails(key: "الوصف", value: viewModel.data.data?.desc ?? Constents.noValue)
            ColumenDetails(key: "جهة الطلب", value: viewModel.data.data?.department ?? Constents.noValue)
            ColumenDetails(key: "اسم المستفيد", value: viewModel.data.data?.department ?? Constents.noValue)
            ColumenDetails(key: "المخصص", value: viewModel.data.data?.provision ?? Constents.noValue)
            ColumenDetails(key: "طريقة الدفع", value: viewModel.data.data?.paytype ?? Constents.defaultPayType)
            Divider()
        }
    }
}
struct DetailsTheridSection:View{
    @ObservedObject var viewModel:PaymentDetailsViewModel
    @Binding var showEditAmount:Bool
    var body: some View{
        VStack(alignment:.leading){
            HStack(alignment:.bottom){
                ColumenDetails(key: "المبلغ", value: String(viewModel.data.data?.amount ?? 0).toArabicNumber()+"ر.س")
                if viewModel.data.data?.hasPermission == true && viewModel.data.data?.hasMadeAction == false{
                    Button {
                        showEditAmount = true
                    } label: {
                        Text("تعديل المبلغ")
                            .padding(5)
                            .background(Color.orange)
                            .cornerRadius(5)
//                            .foregroundColor(.white)
                        
                    }
                }
                
                
            }
            Columen(key: "الحد الائتماني",value: viewModel.data.data?.limit != nil ? String( viewModel.data.data!.limit!).toArabicNumber()+"ر.س": Constents.noValue)
                .padding(.leading,10)
            Divider()
        }
    }
}
struct DetailsAttachmentSection:View{
    var isForwordToMe:Bool
    @Binding var showAttchmentPicker:Bool
    @ObservedObject var viewModel:PaymentDetailsViewModel
    var body: some View{
        VStack(alignment:.leading){
            Text("المرفقات")
                .fontWeight(.bold)
            HStack{
                
                NavigationLink(destination: AttachmentsView(attachments: viewModel.attachments)) {
                    Text("عرض المرفقات")
                        .frame(width: isForwordToMe ? UIScreen.main.bounds.width * 0.3:UIScreen.main.bounds.width * 0.7,height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("brown"), lineWidth: 2)
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
                                    .stroke(Color("brown"), lineWidth: 2)
                            )
                    }
                }
                
            }
            .padding(.top,10)
        }
        .padding(.horizontal,10)
    }
}
