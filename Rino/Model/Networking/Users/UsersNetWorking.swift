//
//  UsersNetWorking.swift
//  Rino
//
//  Created by Ayman Omara on 09/07/2022.
//

import Foundation
import Alamofire
enum UsersNetWorking{
    case logIn(userName:String,passowrd:String)
    case getNotificationCounter
    case paymentProcessHome(from:String,filter:String)
    case getNotification
    case chnagePassowrd(oldPassword:String,newPassword:String)
    case ppSearch(text:String)
    case hrHome(from:String,filter:String)
    case confirmEmail(email:String)
    case submitNewPass(email:String,otp:Int,passowrd:String)
    case ppdetails(id:String)
    case changeApprovalState(path:String)
    case clearanceDetails(path:String)
    case complaints
    case userProfile
    case registerFCMToken(FCMRegisterToken:String)
    case markNotificationRead(id:Int)
    case getDepartmentForCompliants
    case ppSeeAll(url:String)
    case changeLog(requestID:Int)
    case hrSearch(query:String,pageNumber:Int)
    case getPermissionState
    case hrSeeAll(path:String)
    case paymentOrder(filter:String)
    case paymentOrderSearch(query:String,pageNumber:Int)
    case paymentOrderSeeAll(path:String)
}
extension UsersNetWorking:TargetType{
    
    var baseURL: String {
        URLS.baseURL
    }
    var path: String {
        switch self {
        case .logIn:
            return "connect/token"
        case .getNotificationCounter:
            return "api/notifications/new/count"
        case .paymentProcessHome(let from, let filter):
            return "api/requests/\(from)/period/\(filter)"
        case .getNotification:
            return "api/notifications"
        case .chnagePassowrd:
            return "api/identity/password/change"
        case .ppSearch(let text):
            return "api/requests/search/\(text)"
        case .hrHome(let from, let filter):
            return "api/clearancerequests/\(from)/period/\(filter)"
        case .confirmEmail:
            return "api/identity/password/reset"
        case .submitNewPass:
            return "api/identity/password/confirm-reset"
        case .ppdetails(let id):
            return "api/requests/\(id)/details"
        case .changeApprovalState(let path):
            return path
        case .clearanceDetails(let path):
            return path
        case .complaints:
            return "api/complains"
        case .userProfile:
            return "api/identity/profile/"
        case .registerFCMToken:
            return "api/notifications/mobile/add"
        case .markNotificationRead(let id):
            return "api/notifications/read/\(id)"
        case .getDepartmentForCompliants:
            return "api/complains/departments"
        case .ppSeeAll(let url):
            return url
        case .changeLog(let requestID):
            return "api/requests/\(requestID)/amount-changelog"
        case .hrSearch(_,let pageNumber):
            return "api/clearancerequests/search/\(pageNumber)"
        case .getPermissionState:
            return "api/identity/permissions"
        case .hrSeeAll(let path):
            return path
        case .paymentOrder(let filter):
            return "api/orders/period/\(filter)/"
        case .paymentOrderSearch(let query,let pageNumber):
            return "api/orders/query/\(query)/page/\(pageNumber)"
        case .paymentOrderSeeAll(let path):
            return path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .logIn:
            return .post
        case .getNotificationCounter:
            return .get
        case .paymentProcessHome:
            return .get
        case .getNotification:
            return . get
        case .chnagePassowrd:
            return .post
        case .ppSearch:
            return .get
        case .hrHome:
            return .get
        case .confirmEmail:
            return .post
        case .submitNewPass:
            return .post
        case .ppdetails:
            return  .get
        case .changeApprovalState:
            return .post
        case .clearanceDetails:
            return .get
        case .complaints:
            return .get
        case .userProfile:
            return .get
        case .registerFCMToken:
            return .post
        case .markNotificationRead:
            return .put
        case .getDepartmentForCompliants:
            return .get
        case .ppSeeAll:
            return .get
        case .changeLog:
            return .get
        case .hrSearch:
            return .post
        case .getPermissionState:
            return .get
        case .hrSeeAll:
            return .get
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .logIn(let userName,let password):
            return .requestParameter(paramters: ["grant_type":RequestConstents.password,"username":userName,"password":password,"client_id":RequestConstents.clientID], encoding: Alamofire.URLEncoding.default)
        case .chnagePassowrd(let oldPassword, let newPassword):
            return .requestParameter(paramters: ["old" : oldPassword,"new":newPassword], encoding: JSONEncoding.default)
        case .confirmEmail(let email):
            return .requestParameter(paramters: ["email":email], encoding: JSONEncoding.default)
        case .submitNewPass(let email,let otp,let passowrd):
            return .requestParameter(paramters: ["email":email,"otp":otp,"password":passowrd], encoding: JSONEncoding.default)
        case .registerFCMToken(let FCMRegisterToken):
            return .requestParameter(paramters: ["token" : FCMRegisterToken,"deviceid":UIDevice.current.identifierForVendor!.uuidString], encoding: JSONEncoding.default)
        case .hrSearch(let query,_):
            return .requestParameter(paramters: ["query" : query], encoding: JSONEncoding.default)
        default:
            return .resquestPlain
        }
    }
    
    var headers: [String : String]? {
        let localModel = LocalModel.shared
        switch self {
        case .logIn:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .confirmEmail:
            return [:]
        case .submitNewPass:
            return [:]
        default:
            return ["Authorization": "Bearer "+(localModel.getToken().token)]
        }
    }
}
