//
//  ClearanceDetailsViewModel.swift
//  Rino
//MARK:- This class is Responsible for connecting the UI To Model Layer (For Clearance Details)
//  Created by Ayman Omara on 04/10/2021.
//

import Foundation
import Combine

class HRDetailsViewModel:ObservableObject,RefreshToken{
    @Published var showAlert = false
    @Published var isLoading = false
    @Published var data = HRDetailsResponse()

    var attachments = [Attachment]()
    var alert:UserAlert?
    var id:Int!
    var shouldEnableApprovel = true
    var netWork = Network.shared
    var entity: Int!
    @Published var errorcase = NetworkErrorCase.none
    func fetchData() {
        errorcase = .none
        isLoading = true
        UsersAPI.shard.getClearanceDetails(path: "api/clearancerequests/"+String(entity!)+"/"+String(id!)+"/details") {[weak self] response, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                guard let clearanceDetails = response else{
                    self.errorcase = .emptyData
                    return
                }
                if clearanceDetails.success == true{
                    self.data = clearanceDetails
                    if let attachment = clearanceDetails.data?.attachments{
                        self.attachments = attachment
                    }
                }else{
                    self.errorcase = .timeOut
                }
                self.data = clearanceDetails
            }else{
                self.errorcase = errorcase
            }
        }
    }

    func createAttachments(attatchments:[UploadableFile]){
        if attatchments.isEmpty{
            self.showAlert = true
            self.alert = UserAlert(title: Constents.error, body: "عفوا لم يتم اختيار اي مرفقات ، الرجاء الضغط على زر اضافه مرفقات ثم الضغط مره اخرى على تاكيد المرفقات", alertCase: .error)
            return
        }
        isLoading = true
        netWork.createAttachments(attachmentRequest: CreateAttachmentRequest(attatchments: attatchments, requestId: id, RequestType: 1)) { progress in
            
        } complition: {[weak self] attachments, statusCode, message in
            guard let self = self else{return}
            self.isLoading = false
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
        UsersAPI.shard.chnageApprovalState(path:"api/clearancerequests/action/\(entity!)/\(String(id))/\(approvalState)") {[weak self] response, errorcase in
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
}
