//
//  ManagementAlertCard.swift
//  Rino
//
//  Created by Ayman Omara on 03/08/2022.
//

import SwiftUI
import Introspect
struct ManagementAlertCard:View {
    let item:PaymentOrderHomeData
    var body: some View{
        VStack{
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
                }  .foregroundColor(.orange)
                    .background( NavigationLink("", destination:PaymentOrderSeeAllView(start: item.from ?? Constents.noValue, end: item.to  ?? Constents.noValue, currentPageIndex: 1)).opacity(0))
            }
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment:.firstTextBaseline){
                    ForEach(item.items ?? []){ i in
                        PaymentOrderItemCard(request: i)
                            .frame(width:UIScreen.main.bounds.width-95)
                            .padding(.horizontal,5)
                            .foregroundColor(Color(UIColor.label))
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    }
                }
            }.padding(.horizontal, 10)
                .flipsForRightToLeftLayoutDirection(true)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(alignment:.center)
            
        }
    }
}

