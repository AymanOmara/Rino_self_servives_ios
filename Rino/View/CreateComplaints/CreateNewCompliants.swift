//
//  CreateNewCompliants.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import SwiftUI
import SkeletonUI
import SPAlert
struct CreateNewCompliants: View {
    @ObservedObject var viewModel =  CreateCompliantsViewModel()
    @State var showAttachmentPicker = false
    @State var showAttchmentChosser = false
    @State var officer = ""
    @State var compliants = ""
    @State private var attchments = [UploadableFile]()
    @State private var selectedDepartment = ""
    @State private var attchmentType = AttachmentType.none
    @State var isShownen = false
    
    init(){
        viewModel.getDepartments()
    }
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment:.leading){
                Text("الادارة المختصة")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .padding(.top,20)
                DropMenu(options: $viewModel.options, selectedItem: $selectedDepartment,placeHolrder: "الادارة المختصة")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                    )
                
                Text("المسؤل")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .padding(.top,20)
                TextField("المسؤل", text: $officer)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                    )
                Text("الشكاوى والمقترحات")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .padding(.top,20)
                TextView(text: $compliants)
                    .frame(height:100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                    )
                Text("\(String(compliants.count).toArabicNumber())/٥٠٠"+"حرف")
            }
            NavigationLink(destination: ChosenAttachmentsView( chosenAttachments: $attchments), label: {
                Text("عرض المرفقات المختارة")
            })

    
        
        Button {
            showAttchmentChosser = true
        } label: {
            Text("اضافة مرفقات")
                .frame(width:UIScreen.main.bounds.width-60)
                .padding(.vertical, 10)
                .cornerRadius(6)
                .foregroundColor(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.brown), lineWidth: 2)
                )
        }
        Button {
            viewModel
                .createComplianst(dic:
                                    ["Department":selectedDepartment,
                                     "Officer":officer,
                                     "Body":compliants]
                                  , attachments: attchments)
        } label: {
            Text("ارسال")
                .frame(width:UIScreen.main.bounds.width-60)
                .padding(.vertical, 10)
                .background(Color.orange)
                .cornerRadius(6)
                .foregroundColor(Color.white)
            
        }
    }
        .padding(.horizontal,10)
    
        .onAppear{
            UIScrollView.appearance().keyboardDismissMode = .interactive
        }
        .skeleton(with: viewModel.isLoading)
        .shape(type: .rectangle)
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
                    GallaryView(documents: $attchments)
                }else{
                    //FALL Back
                }
            }else if attchmentType == .camera{
                CameraView(documents: $attchments)
            }else if attchmentType == .doucments{
                DocumentsView(documents: $attchments)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .SPAlert(isPresent: $viewModel.showMessage, alertView: SPAlertView(title: viewModel.alert?.title ?? "", message: viewModel.alert?.body ?? "", preset: viewModel.alert?.alertCase ?? .done))
    
}

}

struct CreateNewCompliants_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewCompliants()
    }
}


enum AttachmentType{
    case doucments,gallery,camera,none
}
