//
//  ChosenAttachmentsView.swift
//  Rino
//
//  Created by Ayman Omara on 21/06/2022.
//

import SwiftUI

struct ChosenAttachmentsView: View {
    @Binding var chosenAttachments:[UploadableFile]
    var body: some View {
        if chosenAttachments.isEmpty{
            LottieView(fileName: "emptdata")
                .frame(width: UIScreen.main.bounds.width*0.6, height: 300)
            Text("لا يوجد مرفقات لعرضها")
        }else{
            List{
                ForEach(chosenAttachments){ attachment in
                    NavigationLink(destination: ViewAttachment(attachment: attachment)) {
                        ChosenAttachmentsCell(chosenAttachments: attachment)
                    }
                }
                .onDelete { index in

                    chosenAttachments.remove(atOffsets: index)
                }
            }.environment(\.layoutDirection, .rightToLeft)
        }
    }
}


struct ChosenAttachmentsCell:View{
    var chosenAttachments:UploadableFile
    var body: some View{
        HStack(alignment:.top){
            Image(uiImage: chosenAttachments.image)
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack(alignment:.leading){
                HStack(alignment:.top){
                    Text("اسم المرفق:")
                    Text(chosenAttachments.fileName)
                }
                HStack(alignment:.top){
                    Text("نوع المرفق:")
                    Text(chosenAttachments.fileExtension)
                }
            }
        }
    }
}
