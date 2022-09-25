//
//  Item.swift
//  Rino
//
//  Created by Ayman Omara on 14/08/2022.
//

import SwiftUI

struct PaymentOrderItemCard: View {
    let request:PaymentOrderItem
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                RowData(key: "رقم الطلب", value: request.requestID != nil ? String(request.requestID!).toArabicNumber(): Constents.noValue )
                Spacer()
                Text(request.status_date?.components(separatedBy: "T")[0].toArabicDate())
            }.padding(.bottom,10)
            Divider()
                .padding(.bottom,10)
            
            HStack(alignment:.top){
                Text("اسم الشخص"+" : ")
                    .fontWeight(.semibold)
                    
                + Text(request.custom_data?.beneficiary ?? Constents.noValue)
                
            }.padding(.bottom,10)
           
            HStack{
                Text("نوع الطلب"+" : ")
                    .fontWeight(.semibold)
                
                + Text(request.custom_data?.details ?? Constents.noValue)
            }
            .padding(.bottom,10)
            
            RowData(key: "المبلغ", value: request.custom_data?.amount != nil ? String(request.custom_data!.amount!).toArabicNumber()+"ر.س" :Constents.noValue)
            
        }
        .padding(14)
        .environment(\.layoutDirection, .rightToLeft)
        .cornerRadius(10)
        
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.orange, lineWidth: 2)
        )
    }
}
struct ManagementAlertCard_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOrderItemCard(request: PaymentOrderItem())
    }
}
