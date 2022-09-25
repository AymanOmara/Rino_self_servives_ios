//
//  CreateCompliantsViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 27/06/2022.
//

import Foundation
import Combine
class CreateCompliantsViewModel:ObservableObject{
    @Published var options = [String]()
    @Published var isLoading = true
    var alert:UserAlert?
    @Published var showMessage = false
    
    var network = Network.shared
    
    func getDepartments(){
        isLoading = true
        UsersAPI.shard.getDepartmentsForComplaints {[weak self] departments, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if let departments = departments{
                self.options = departments
            }
        }
    }
    func createComplianst(dic:[String:String],attachments:[UploadableFile]?){
        if !isValidRequest(dic: dic){
            return
        }
        isLoading = true
        network.createNewCompliansts(dic: dic, attachments: attachments) {[weak self] (message,statusCode) in
            guard let self = self else{return}
            self.isLoading = false
            
            if statusCode == 200{
                self.alert = UserAlert(title: Constents.done, body: "تم اضافة الشكوى بنجاح", alertCase: .done)
                self.showMessage = true
            }else{
                
            }
            
        }
    }
    func isValidRequest(dic:[String:String])->Bool{
        if dic["Department"]?.isEmpty == true{
            alert = UserAlert(title: Constents.error, body: "من فضلك ادخل بيانات الادارة المختصة", alertCase: .error)
            showMessage = true
            return false
        }else if dic["Officer"]?.isEmpty == true{
            alert = UserAlert(title: Constents.error, body: "من فضلك ادخل بيانات المسؤل", alertCase: .error)
            showMessage = true
            return false
        }else if dic["Body"]?.isEmpty == true{
            alert = UserAlert(title: Constents.error, body: "من فضلك ادخل الشكوى", alertCase: .error)
            showMessage = true
            return false
        }else{
            return true
        }
    }
}
