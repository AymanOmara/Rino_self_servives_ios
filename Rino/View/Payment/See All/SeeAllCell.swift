//
//  SeeAllCell.swift
//  Rino
//
//  Created by Ayman Omara on 05/07/2022.
//

import Foundation
import SwiftUI
struct PPSeeAllCard:View{
    var item:PaymentItem
    var isForwordToMe:Bool
    var body: some View{
        VStack(alignment:.leading){
            FirstSection(id: String(item.id ?? 0).toArabicNumber(), date: item.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
            SecondSection(department: item.department ?? Constents.noValue, amount: String(item.amount ?? 0).toArabicNumber(), balance: item.balance == nil ? Constents.noValue : String(item.balance!).toArabicNumber(), paymentMethod: item.payType ?? Constents.noValue)
            LastSection(requestState: item.status ?? Constents.noValue, forwordTo: item.current?.users != nil ? item.current?.users?.isEmpty == false ?  item.current?.users ?? [Constents.noValue] : [Constents.noValue] : [Constents.noValue], color: Color.orange, isForwordToMe: isForwordToMe)
            
        }
        .environment(\.layoutDirection, .rightToLeft)
        .padding(5)
        .padding(.vertical,5)
        .padding(.horizontal,10)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.orange, lineWidth: 2)
        )
        .padding([.top, .horizontal])
    }
}

struct FirstSection:View{
    var idTitle = "رقم الطلب"
    var id:String
    var dateTitle = "تاريخ الطلب"
    var date:String
    
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text(idTitle)
                    .fontWeight(.semibold)
                Spacer()
                Text(dateTitle)
                    .fontWeight(.semibold)
            }
            HStack{
                Text(id)
                    .padding(.top,5)
                Spacer()
                Text(date)
                    .padding(.top,5)
            }
            Divider()
        }
    }
}
struct SecondSection:View{
    var department,amount,balance,paymentMethod:String
    var body: some View{
        VStack(alignment:.leading){
            Columen(key: "الجهة", value: department)
            
            HStack{
                RowData(key: "المبلغ", value: amount+"ر.س")
            }.padding(.top,10)
            Columen(key: "طريقة الدفع", value: paymentMethod)
            Divider()
        }
    }
}
struct LastSection:View{
    var requestState:String
    var forwordTo:[String]
    var color:Color
    var isForwordToMe:Bool
    var body: some View{
        VStack(alignment:.leading){
            RequestState(key: "حالة الطلب", value: requestState, valueColor: isForwordToMe ? Color.orange : Color.rinoBrown)
            if !isForwordToMe{
                HStack{
                    Text("محالة الى")
                    //                    ScrollView(.horizontal,showsIndicators: false) {
                    
                    ScrollView{
                        HStack(alignment:.top){
                            ForEach(forwordTo){ item in
                                Text(item)
                                    .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                                    .padding(.horizontal,6)
                                    .padding(.vertical,3)
                                    .foregroundColor(Color.white)
                                    .background(RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .fill(color))
                                
                            }
                            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 0)
                            .padding(.vertical,2)
                        }
                    }
                    //                    }
                    //                    .padding(.top,5)
                    //                    .flipsForRightToLeftLayoutDirection(true)
                    //                    .environment(\.layoutDirection, .rightToLeft)
                }
            }
        }
    }
}
extension String:Identifiable{
    public var id:UUID{
        return UUID()
    }
}
