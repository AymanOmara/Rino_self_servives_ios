//
//  ResetPasswordViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 12/12/2021.
//

import Foundation
import Combine
class ResetPasswordViewModel : ObservableObject{
    
    @Published var isLoading = false
    @Published var message = ""
    @Published var isSuccess = false
    
    func isValidEmail(email:String) -> Bool {
        if email.isEmpty{
            message = "هذا الحقل مطلوب"
            return false
        }else{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if !emailPred.evaluate(with: email){
                message = "من فضلك ادخل ايميل صالح"
            }
        return emailPred.evaluate(with: email)
        }
    }
    
    
    
    func fetchData(email:String) {
        isLoading = true
        UsersAPI.shard.confirmEmail(email: email) {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if let response = response{
                if let success = response.success{
                    if success{
                        self.isSuccess = success
                    }else{
                        self.message = response.message ?? MessagesToUser.timeOut.message
                    }
                }
            }else{
                self.message = errorcase.rawValue
            }
        }
    }
    

    
}
