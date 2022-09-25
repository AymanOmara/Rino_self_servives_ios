//
//  Cell.swift
//  Rino
//
//  Created by Ayman Omara on 18/07/2022.
//

import SwiftUI

struct HomePaymentCell:View{
    var item:PPData
    var isMe:Bool
    var body: some View{
        VStack(alignment:.center){
            HStack{
                Text(item.title ?? Constents.noValue)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .padding(.leading,10)
                
                Text(item.count != nil ? "("+String(item.count!).toArabicNumber()+"طلب)" : Constents.noValue)
                    .font(.system(size: 14))
                
                Spacer()
                HStack{
                    Image(systemName: "square.grid.2x2")
                        .resizable()
                        .frame(width:20,height: 20)
                        .scaledToFit()
                    Text("عرض الكل")
                        .padding(.trailing,10)
                }
                .foregroundColor(.orange)
                .background( NavigationLink("", destination: PPSeeAllView(startDate: item.start ?? Constents.noValue, endDate: item.end ?? Constents.noValue, isForwordToMe: isMe)).opacity(0))
            }.padding(.top,5)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment:.top){
                    ForEach(item.items ?? []){ i in
                        NavigationLink(destination: PPDetailsView(id: i.requestID!, isForwordToMe: isMe), label: {
                            PaymentHorizontalCell(item: i,isme:isMe)
                                .frame(width:UIScreen.main.bounds.width-95)
                            
                                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 1)
                                .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color(UIColor.systemBackground)))
                                .padding(.horizontal,8)
                                .padding(.top,10)
                                .padding(.bottom,7)
                                .foregroundColor(Color(UIColor.label))
                                .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                        })
                    }
                }
            }
            .padding(.horizontal, 10)
                .flipsForRightToLeftLayoutDirection(true)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(alignment:.center)
        }.background(RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color(UIColor.systemBackground)))
        .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 0)
    }
}
struct PaymentHorizontalCell:View{
    var item:Item
    var isme:Bool
    var body: some View{
        VStack(alignment:.leading){
            FirstSection(id: item.requestID != nil ? String(item.requestID!).toArabicNumber() : Constents.noValue , date: item.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
            SecondSection(department: item.department ?? Constents.noValue, amount: item.amount != nil ? String(item.amount!).toArabicNumber() :Constents.noValue, balance: item.balance != nil ? String(item.balance!).toArabicNumber()+"ر.س" :Constents.noValue, paymentMethod: item.paymentmethod ?? Constents.noValue)
            
            LastSection(requestState: item.status ?? Constents.noValue, forwordTo: item.current?.users != nil ? item.current?.users?.isEmpty == false ?  item.current?.users ?? [Constents.noValue] : [Constents.noValue] : [Constents.noValue], color: Color.orange, isForwordToMe: isme)
        }
        
        .environment(\.layoutDirection, .rightToLeft)
        .padding(5)
        .padding(.horizontal,5)
        .cornerRadius(10)
        
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.orange, lineWidth: 2)
        )
    }
}
