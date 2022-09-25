//
//  ChangeLogCell.swift
//  Rino
//
//  Created by Ayman Omara on 03/07/2022.
//

import SwiftUI
struct ChangeLogCell:View{
    let item:ChnageLogItem
    var body: some View{
        VStack(alignment:.leading){
            FirstSection(idTitle: "رقم الحركة", id: item.requestId != nil ? String(item.requestId!).toArabicNumber() : Constents.noValue
                         , dateTitle: "تاريخ الحركة", date: item.createdAt?.components(separatedBy: " ")[0].toArabicDate() ?? Constents.noValue)
            Columen(key: "رقم الموظف", value: item.employeeId != nil ? String(item.employeeId!).toArabicNumber() : Constents.noValue)
            Columen(key: "اسم الموظف", value: item.employeeName ?? Constents.noValue)
            Columen(key: "الوظيفة", value: "")
            Columen(key: "الادارة", value: item.departmentName ?? Constents.noValue)
            Divider()
            Columen(key: "المبلغ الحالي", value: item.newAmount != nil ? String(item.newAmount!).toArabicNumber()+"ر.س" : Constents.noValue )
            Columen(key: "المبلغ القديم", value: item.oldAmount != nil ? String(item.oldAmount!).toArabicNumber()+"ر.س"  : Constents.noValue)
            if let oldAmount = item.oldAmount , let newAmount = item.newAmount{
                Columen(key: "فرق المبلغ", value: String(newAmount-oldAmount).toArabicNumber()+"ر.س")
            }
            

        }
        .padding(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                        lineWidth: 4)
                .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255),
                        radius: 3, x: 0, y: 0)
                .clipShape(

                    RoundedRectangle(cornerRadius: 15)
                )
                .shadow(color: Color.white, radius: 1, x: 0, y: 0)
                .clipShape(
                    RoundedRectangle(cornerRadius: 15)
                )
        )

        .cornerRadius(20)
    }
}
