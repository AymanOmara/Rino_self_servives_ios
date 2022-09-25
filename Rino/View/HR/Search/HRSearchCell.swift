//
//  HRSearchCell.swift
//  Rino
//
//  Created by Ayman Omara on 05/07/2022.
//

import SwiftUI

struct HRSearchCell: View {
    var item:HRSearchData
    var isFromMe:Bool
    var body: some View {
        VStack{
            FirstSection(idTitle: "رقم المخالصة", id: item.id != nil ? String(item.id!).toArabicNumber() : Constents.noValue, date: item.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
            HRSearchSecondSection(item: item)
            HRSeeAllThiredSection(status: item.status ?? Constents.noValue, forwordTo: item.current?.users?.isEmpty == false ? item.current?.users?[0] ?? Constents.noValue : Constents.noValue, isFromMe: isFromMe)
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

struct HRSearchCell_Previews: PreviewProvider {
    static var previews: some View {
        HRSearchCell(item: HRSearchData(), isFromMe: false)
    }
}
struct HRSearchSecondSection:View{
    var item:HRSearchData
    var body: some View{
        VStack(alignment:.leading){
            Columen(key: "رقم الموظف",value: item.code?.toArabicNumber())
            Columen(key: "اسم الموظف",value: item.employee)
            Columen(key: "الادارة",value: item.department)
            Divider()
        }
    }
}
