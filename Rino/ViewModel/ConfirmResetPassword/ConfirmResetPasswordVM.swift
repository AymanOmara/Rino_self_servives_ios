//
//  ConfirmResetPassword.swift
//  Rino
//
//  Created by Ayman Omara on 12/12/2021.
//

import Foundation
import Combine

class ConfirmResetPasswordVM:ObservableObject{
    
    var email = ""
    @Published var message = ""
    @Published var isLoading = false
    @Published var successState = false
    @Published var otpmessage = ""
    @Published var passowrdmessage = ""
    @Published var confrimPasswordMessage = ""
    func isValidPassword(testStr: String?) -> Bool {
        guard testStr != nil else { return false }
        // at least one sepcial case
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[^A-Za-z0-9])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func submit(otp:String,password:String,confrimPassword:String) {
        message = ""
        if otp.isEmpty || password.isEmpty || confrimPassword.isEmpty {
            return
        }
        if !otp.isNumeric{
            otpmessage = "الرجاء ادخال رمز تحقق صالح"
            return
        }else{
            otpmessage = ""
        }
        if !isValidPassword(testStr: password) || password.isEmpty{
            passowrdmessage = "من فضلك ادخل كلمة مرور صالحة"
            return
        }else{
            passowrdmessage = ""
        }
        if confrimPassword != password{
            confrimPasswordMessage = "تأكيد كلمه المرور غير مطابق لكلمه المرور"
            return
        }else{
            confrimPasswordMessage = ""
        }
        isLoading = true
        if otpmessage.isEmpty && passowrdmessage.isEmpty && confrimPasswordMessage.isEmpty{
            UsersAPI.shard.submitNewPass(email: email, otp: otp.isNumeric ? Int(otp)! : 0, passowrd: password) {[weak self] response, errorcase in
                guard let self = self else{return}
                self.isLoading = false
                print(response?.message)
                print(response?.success)
                if let response = response{
                    if response.success == true{
                        self.successState = true
                    }else{
                        self.message = response.message ?? MessagesToUser.timeOut.message
                    }
                }
                
            }
        }
    }
    func isValidotp(otp:String){
        let englishOTP = otp.toEnglishNumber()
        if !englishOTP.isNumeric{
            otpmessage = "الرجاء ادخال رمز تحقق صالح"
        }else{
            otpmessage = ""
        }
    }
    
    
    
    
    
}
