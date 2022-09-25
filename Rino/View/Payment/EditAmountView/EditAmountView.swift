//
//  EditAmountView.swift
//  Rino
//
//  Created by Ayman Omara on 28/06/2022.
//

import SwiftUI
import Combine
import SPAlert
struct EditAmountView: View {
    @Binding var isShown:Bool
    @Binding var changeAmount:ChangeAmount
    @State var differentiation = ""
    var oldAmount:Double
    @State var newAmount = ""
    var tobeIncreased = "زياده المبلغ بمقدار"
    var tobedescreased = "نقصان المبلغ بمقدار"
    @State var editAmountMessage = ""
    @State var errorMessage = ""
    @State var showError = false
    @State var isNotNumber = true
    var body: some View {
        Form{
            Section {
                TextField("ادخل المبلغ الجديد", text: $newAmount)
                
            } header: {
                Text("علما بان المبلغ الحالي هوا"+" "+String(oldAmount).toArabicNumber()+"ر.س")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                
            } footer: {
                Text(editAmountMessage)
            }
            Section{
                VStack{
                    HStack{
                        HStack{
                            Text("تعديل المبلغ")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.orange)
                                .cornerRadius(7)
                            
                        }
                        .onTapGesture {
                            if isNotNumber{
                                showError = true
                            }else{
                                changeAmount = ChangeAmount(newAmount: newAmount.toEnglishNumber().double ?? 0, shouldChangeAmount: true)
                                isShown = false
                            }
                        }
                        Spacer()
                        HStack{
                            Text("رجوع/الغاء")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.orange)
                                .cornerRadius(7)
                        }
                        .onTapGesture {
                            isShown = false
                        }
                    }
                }
                
                
            }
            
            .onReceive(Just(newAmount)) { value in
                if value.isEmpty{
                    editAmountMessage = ""
                    return
                }
                if let val = newAmount.toEnglishNumber().double{
                    
                    if val > oldAmount{
                        editAmountMessage = "هل انت موافق على تعديل المبلغ ليتم"+" "+tobeIncreased+String(val-oldAmount).toArabicNumber()+"ر.س"
                    }else if val < oldAmount{
                        editAmountMessage = "هل انت موافق على تعديل المبلغ ليتم"+tobedescreased+" "+String(val-oldAmount).toArabicNumber()+"ر.س"
                    }
                    isNotNumber = false
                }else{
                    isNotNumber = true
                }


            }
            .SPAlert(isPresent: $showError, alertView: SPAlertView(title: Constents.error, message: "هذا الحقل يقبل الارقام فقط", preset: .error))
            
        }
        .environment(\.layoutDirection, .rightToLeft)
        .frame(width: UIScreen.main.bounds.width-50, height: 200)
        
        .background(Color.black.opacity(0.5))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("brown"), lineWidth: 2)
        )
        .cornerRadius(12)
        .clipped()
        
        
        .environment(\.layoutDirection, .rightToLeft)
    }
}

//struct EditAmountView_Previews: PreviewProvider {
//    static var previews: some View {
////        EditAmountView(isShown: , changeAmount: <#T##Binding<ChangeAmount>#>, oldAmount: <#T##Double#>)
////        Text("")
////        EditAmountView(changeAmount: Binding<ChangeAmount>, oldAmount: 300)
//    }
//}
extension StringProtocol {
    var double: Double? { Double(self) }
    var float: Float? { Float(self) }
    var integer: Int? { Int(self) }
}
class ChangeAmount{
    var newAmount:Double?
    var shouldChangeAmount:Bool?
    init(newAmount:Double,shouldChangeAmount:Bool){
        self.shouldChangeAmount = shouldChangeAmount
        self.newAmount = newAmount
    }
    
    init(){}
}
