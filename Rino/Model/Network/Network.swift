//
//  Repo.swift
//  Rino
// MARK:- This class is is responsable for API Calls


//MARK:- End

//
//  Created by Ayman Omara on 29/08/2021.
//

import Foundation
import Alamofire
class Network{
    static let shared = Network()
    private var localModel:LocalModel!

    //MARK:- Hnadel if there is error in refresh token
    func refreshToken(complition:@escaping(UserToken?)->Void){
        let body = Body(grant_type: RequestConstents.refreashToken, client_id: RequestConstents.clientID,refresh_token: localModel.getToken().refresh)
        let encoder = URLEncodedFormParameterEncoder(destination: .httpBody)
        AF.request(URLS.baseURL+URLS.token, method: .post, parameters: body,encoder: encoder).responseDecodable(of: UserToken.self){response in
            switch(response.result){
                
            case .success(_):
                let data = response.value
                if let token = data?.access_token ,let refresh = data?.refresh_token{
                    self.localModel.setToken(token: token , refreshToken: refresh)
                    complition(data)
                }else{
                    complition(nil)
                    
                }
            case .failure(_):
                break
            }
        }
    }


    private init(){
        localModel = LocalModel.shared
    }
}
extension Network{
    func createAttachments(attachmentRequest:CreateAttachmentRequest,progressComplition:@escaping(Double)->Void,complition:@escaping([Attachment]?,Int?,String?)->Void){
        let headers: HTTPHeaders! = [.authorization(bearerToken: localModel.getToken().token)]

        AF.upload(multipartFormData: { multipartFormData in
            attachmentRequest.attatchments.map{(it) in
                multipartFormData.append(it.file,withName: "Attachments",fileName: "\(it.fileName)",mimeType:"*/*")
            }

            multipartFormData.append(Data(String(Int(attachmentRequest.requestId)).utf8), withName :"Id")
            multipartFormData.append(Data(String(attachmentRequest.RequestType).utf8), withName :"RequestType")
        }, to: URLS.baseURL+"api/Attachments",method: .post,headers: headers).uploadProgress(closure: { (progress) in
            progressComplition(progress.fractionCompleted)
        }).responseDecodable(of:[Attachment].self){response in
            switch response.result{
            case .success(_):
                complition(response.value, response.response?.statusCode,nil)
            case .failure(let error):
                complition(response.value, response.response?.statusCode,error.localizedDescription)
                
            }
        }
    }
}

extension Network{
    func createNewCompliansts(dic:[String:String],attachments:[UploadableFile]?,complition:@escaping(String?,Int?)->Void){
        let headers: HTTPHeaders = [.authorization(bearerToken: localModel.getToken().token)]
        
        AF.upload(multipartFormData: { multipartFormData in
            if let attachments = attachments {
                attachments.map{(it) in
                    if it.fileName == "png"{
                        
                        multipartFormData.append(UIImage(data: it.file)!.jpegData(compressionQuality: 0.1)!,withName: "Attachments",fileName: "\(it.fileName+it.fileExtension)",mimeType:"*/*")
                    }else if it.fileName.contains("pdf") == true {
                        multipartFormData.append(it.file,withName: "Attachments",fileName: "\(it.fileName)",mimeType:"*/*")
                    }

                    else{
                        multipartFormData.append(UIImage(data: it.file)!.jpegData(compressionQuality: 0.1)!,withName: "Attachments",fileName: "\(it.fileName+"."+it.fileExtension)",mimeType:"*/*")
                    }
                }
            }
            
            for (key,value) in dic{
                multipartFormData.append(Data(value.utf8), withName :key)
            }
            
            
        }, to: URLS.baseURL+"api/complains",method: .post,headers: headers).uploadProgress(closure: { (progress) in
            
        }).response{response in
            switch response.result{
            case .success(_):
                complition(nil,response.response?.statusCode)
            case .failure(let error):
                complition(error.localizedDescription,response.response?.statusCode)
                
            }
        }
    }
}

extension Network{
    func editPaymentAmount(requestId:Int,newAmount:Double,complition:@escaping(EditAmountResponse?,Int?,String)->Void){
        let headers: HTTPHeaders = [.authorization(bearerToken: localModel.getToken().token)]
        AF.request("https://rino-app-staging.azurewebsites.net/api/requests/\(requestId)/edit-amount",method: .post,parameters: ["newAmount":newAmount],encoding: JSONEncoding.default,headers: headers).responseDecodable(of:EditAmountResponse.self) { response in
            switch(response.result){
            case .success(_):
                complition(response.value, response.response?.statusCode,"")
            case .failure(let error):
                complition(nil, response.response?.statusCode,error.localizedDescription)
            }
        }
    }
}
struct RestPasswordRequest:Codable{
    let email,password:String
    let otp:Int
}
