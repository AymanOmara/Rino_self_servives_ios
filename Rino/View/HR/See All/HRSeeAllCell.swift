//
//  HRSeeAllCell.swift
//  Rino
//
//  Created by Ayman Omara on 04/07/2022.
//

import SwiftUI

struct HRSeeAllCell: View {
    var item:HRSeeAllData
    var isFromMe:Bool
    var body: some View {
        VStack{
            FirstSection(idTitle: "رقم المخالصة", id: item.id != nil ? String(item.id!).toArabicNumber() : Constents.noValue, date: item.date?.components(separatedBy: "T")[0].toArabicDate() ?? Constents.noValue)
            HRSecondSection(employeeCode: item.code?.toArabicNumber(), employeeName: item.employee, department: item.department)
            HRSeeAllThiredSection(status: item.status ?? Constents.noValue, forwordTo: item.current?.users != nil ? item.current?.users?.isEmpty == false ?  item.current?.users?[0] ?? Constents.noValue : Constents.noValue : Constents.noValue, isFromMe: isFromMe)
            VacationView(type: item.type ?? Constents.noValue, start: item.start ?? Constents.noValue, end: item.end ?? Constents.noValue)
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

struct HRSeeAllCell_Previews: PreviewProvider {
    
    static var previews: some View {
        HRSeeAllCell(item: HRSeeAllData(), isFromMe: false)
    }
}
struct HRSecondSection:View{
    var employeeCode,employeeName,department:String?
    var body: some View{
        VStack(alignment:.leading){
            Columen(key: "رقم الموظف",value: employeeCode)
            Columen(key: "اسم الموظف",value: employeeName)
            Columen(key: "الادارة",value: department)
            Divider()
        }
    }
}
struct HRSeeAllThiredSection:View{
    var status:String
    var forwordTo:String
    var isFromMe:Bool
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("حالة الطلب")
                    
                Container(color: .orange,text: status)
                Spacer()
            }
            HStack{
                if !isFromMe{
                    Text("محال الي ")
                        
                    Container(color: .gray,text: forwordTo)
                    Spacer()
                }
            }
            .padding(.vertical,5)
        }
    }
}
struct CardView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                            lineWidth: 4)
                    .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255),
                            radius: 3, x: 0, y: 0)
                    .clipShape(

                        RoundedRectangle(cornerRadius: 20)
                    )
                    .shadow(color: Color.white, radius: 1, x: 0, y: 0)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
            )

            .cornerRadius(20)
    }
}
extension View {
    func toCard() -> some View {
        modifier(CardView())
    }
}
