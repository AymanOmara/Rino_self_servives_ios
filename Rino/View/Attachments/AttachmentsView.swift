//
//  AttachmentsView.swift
//  Rino
//
//  Created by Ayman Omara on 22/06/2022.
//

import SwiftUI

struct AttachmentsView: View {
    var attachments:[Attachment]
    var body: some View {
        if !attachments.isEmpty{
            List{
                ForEach(attachments){ attachment in
                        AttachmentCell(attachment: attachment)
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: attachment.url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
                        }
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
        }else{
            VStack{
                LottieAnimationView(fileName: "emptdata")
                Text("لا توجد مرفقات لهذا الطلب")
            }
        }
    }
}

struct AttachmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AttachmentsView(attachments: [Attachment()])
    }
}
struct AttachmentCell:View{
    var attachment:Attachment
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("اسم المستخدم")
                Text(attachment.username ?? Constents.noValue)
            }
            HStack{
                Text("الوظيفة")
                Text(attachment.jobTitle ?? Constents.noValue)
            }
            HStack{
                Text("تاريخ الانشاء")
                Text(attachment.date ?? Constents.noValue)
            }
            HStack{
                Text("اسم المرفق")
                Text(attachment.name ?? Constents.noValue)
            }
        }
    }
}
