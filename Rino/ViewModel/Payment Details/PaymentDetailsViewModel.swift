//
//  PaymentDetailsViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 21/09/2021.
//
//MARK:- Refactor 
import Foundation
import Combine

class PaymentDetailsViewModel :ObservableObject{
    @Published var showAlert = false
    @Published var isLoading = false
    @Published var data = PaymentProceesDetailsResponse()
    @Published var error = ""
    var message = ""
    var attachments = [Attachment]()
    var alert:UserAlert?
    var id:Int!
    var shouldEnableApprovel = true
    @Published var isGM = false
    private let network = Network.shared
    @Published var errorcase:NetworkErrorCase = .none
    func fetchData(){
        errorcase = .none
        error = ""
        isLoading = true
        UsersAPI.shard.getPaymentDetails(id: String(id)) {[weak self] payment, errorcase in
            guard let self = self else {return}
            if errorcase == .none{
                guard let payment = payment else{
                    self.error = MessagesToUser.timeOut.message
                    return
                }
                self.data = payment
                self.attachments = payment.data?.attachments ?? []
                self.getEmployeeJobTitle()
            }else{
                self.errorcase = errorcase
            }
        }
    }
    func getEmployeeJobTitle(){
        UsersAPI.shard.getPermissonState {[weak self] state, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            guard let state = state else{return}
            self.isGM = state.isGM
        }
    }
    
    func createAttachments(attatchments:[UploadableFile]){
        if attatchments.isEmpty{
            self.showAlert = true
            self.alert = UserAlert(title: Constents.error, body: "عفوا لم يتم اختيار اي مرفقات ، الرجاء الضغط على زر اضافه مرفقات ثم الضغط مره اخرى على تاكيد المرفقات", alertCase: .error)
            return
        }
        isLoading = true
        network.createAttachments(attachmentRequest: CreateAttachmentRequest(attatchments: attatchments, requestId: id, RequestType: 0)) { progress in
            
        } complition: {[weak self] attachments, statusCode, message in
            guard let self = self else{return}
            self.showAlert = true
            if statusCode == 200{
                if let attachments = attachments{
                    self.alert = UserAlert(title: Constents.done, body: "تم تعديل بيانات المرفقات بنجاح", alertCase: .done)
                    self.attachments.append(contentsOf: attachments)
                    
                }
            }else{
                self.alert = UserAlert(title: Constents.error, body: "حدث خطأ اثناء تعديل بيانات المرفقات الرجاء المحاوله في وقت لاحق", alertCase: .error)
            }
        }
    }
    func approveOrDeny(approvalState:String){
        isLoading = true
        UsersAPI.shard.chnageApprovalState(path:"api/requests/action/\(String(id))/\(approvalState)") {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            self.showAlert = true
            if errorcase == .none{
                if let responseMessage = response?.message {
                    self.alert = UserAlert(title: Constents.error, body: responseMessage, alertCase: .error)
                }
                if response?.success == true{
                    self.shouldEnableApprovel = false
                    self.alert = UserAlert(title: Constents.done, body: "تم تعديل بيانات حاله الطلب بنجاح", alertCase: .done)
                    if let response = response{
                        self.data.data?.current = response.data?.current
                        self.data.data?.step = response.data?.step
                        self.data.data?.status_date = response.data?.status_date
                    }
                }
            }else{
                self.alert = UserAlert(title: Constents.error, body: errorcase.rawValue, alertCase: .error)
            }
        }
    }
    func editAmount(newAmount:Double){
        message = ""
        isLoading = true
        network.editPaymentAmount(requestId: id, newAmount: newAmount) {[weak self] response, statusCode, message in
            guard let self = self else{return}
            self.isLoading = false
            if statusCode == 200{
                self.data.data?.amount = newAmount
                self.showAlert = true
                self.alert = UserAlert(title: Constents.done, body:"تم تعديل المبلغ الخاص بهذا الطلب بنجاح", alertCase: .done)
            }else if message.contains("offline"){
                
                self.error = MessagesToUser.noConnection.message
            }else if response?.status == false{
                if let message = response?.message{
                    self.showAlert = true
                    self.alert = UserAlert(title: Constents.error, body:message, alertCase: .error)
                }
            }
            
        }
    }
    func approveOrDenyURL(approvalState:String,id:Int)->String{
        return URLS.baseURL+"api/requests/action/\(id)/\(approvalState)"
    }
}
