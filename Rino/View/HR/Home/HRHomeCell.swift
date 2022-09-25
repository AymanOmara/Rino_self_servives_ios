//
//  HRHomeCell.swift
//  Rino
//
//  Created by Ayman Omara on 18/07/2022.
//

import SwiftUI

struct HRHomeCell: View {
    var item:HRHomePageData
    var isMe:Bool
    @State private var isNavigationActive = false
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
                }
                .foregroundColor(.orange)
                .background( NavigationLink("", destination: HRSeeAll(start: item.start ?? "", end: item.end ?? "", isFromME: isMe)).opacity(0))
            }.padding(.top,5)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment:.firstTextBaseline){
                    ForEach(item.items ?? []){ i in
                        
                        NavigationLink(destination: HRDetailsView(id:i.requestID ?? 0,isForwordToMe: isMe,entity: i.entity ?? 0), label: {
                            HRHomeHorizontalCell(item: i,isFromMe:isMe)
                                .frame(width:UIScreen.main.bounds.width-95)
                                .padding(.horizontal,5)
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
            
        }
    }
}
struct HRHomeHorizontalCell: View {
    var item:Item
    var isFromMe:Bool
    var body: some View {
        VStack{
            FirstSection(idTitle: "رقم المخالصة", id: item.requestID != nil ? String(item.requestID!).toArabicNumber() : Constents.noValue, date: item.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
            HRSecondSection(employeeCode: item.code?.toArabicNumber(), employeeName: item.employee, department: item.department)
            
            HRSeeAllThiredSection(status: item.status ?? Constents.noValue, forwordTo: item.current?.users != nil ? item.current?.users?.isEmpty == false ?  item.current?.users?[0] ?? Constents.noValue : Constents.noValue : Constents.noValue, isFromMe: isFromMe)
            
            VacationView(type: item.type ?? Constents.noValue, start: item.start ?? Constents.noValue, end: item.end ?? Constents.noValue)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .padding(5)
        .padding(.horizontal,5)
        .cornerRadius(10)
        
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.orange, lineWidth: 2)
        )
    }
}
