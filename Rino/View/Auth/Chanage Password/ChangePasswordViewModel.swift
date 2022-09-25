//
//  ChangePasswordViewModel.swift
//  Rino
//MARK:- This class is Responsible for connecting the UI To Model Layer (Rest password in the settings)
//  Created by Ayman Omara on 13/10/2021.
//

import Foundation
import Combine
class ChangePasswordViewModel:ObservableObject {
    @Published var isLoading = false
    @Published var message = ""
    @Published var isSuccess = false
    @Published var showAlert = false
    @Published var userAlert:UserAlert?
    func chnagePassowrd(old:String,new:String){
        if old.isEmpty || new.isEmpty{
            message = "يجب ادخال كلمه المرور القديمه والحاليه لاستكمال العمليه"
        }
       else if isValidPassowrd(password: new){
            isLoading = true
            UsersAPI.shard.chnagePassowrd(oldPassword: old, newPassowrd: new) {[weak self] response, errorcase in
                guard let self = self else{return}
                self.isLoading = false
                if let response = response{
                    self.showAlert = true
                    if response.success == true{
                        self.userAlert = UserAlert(title: Constents.done, body: "تم تغيير كلمه المرور بنجاح", alertCase: .done)
                    }else{
                        self.userAlert = UserAlert(title: Constents.error, body: response.message ?? "حدث خطا اثناء تغيير كلمه المرور", alertCase: .error)
                    }
                }
            }
        }else{
            message = "كلمه المرور الجديدة غير مطابقة للمعايير"
        }
    }
    func isValidPassowrd(password:String) -> Bool {

        if password.lowercased().contains("admin"){
            return false
        }else{
            let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#_])[A-Za-z\\dd$@$!%*?&#_]{8,}")
            return passwordTest.evaluate(with: password)
        }
    }
}
