//
//  UsersAPI.swift
//  Rino
//
//  Created by Ayman Omara on 09/07/2022.
//

import Foundation
class UsersAPI:BaseAPI<UsersNetWorking>,UsersAPIProtocol{
    static let shard = UsersAPI()
    private override init() {}
    func logIn(userName:String,password:String,complition:@escaping(UserToken?,NetworkErrorCase)->Void){
        fetchData(target: .logIn(userName: userName, passowrd: password), responseClass: UserToken.self) { userToken, errorcase in
            complition(userToken, errorcase)
        }
    }
    func getNotificationCounter(complition:@escaping(NotificationCount?,NetworkErrorCase)->Void){
        fetchData(target: .getNotificationCounter, responseClass: NotificationCount.self) { notifications, errorcase in
            complition(notifications,errorcase)
        }
    }
    func getPaymentProcessHome(from:String,filter:String,complition:@escaping(PaymentProcessResponse?,NetworkErrorCase)->Void){
        fetchData(target: .paymentProcessHome(from: from, filter: filter), responseClass: PaymentProcessResponse.self) { payments, errorcase in
            complition(payments,errorcase)
        }
    }
    func getNotifications(complition:@escaping(RinoNotification?,NetworkErrorCase)->Void){
        fetchData(target: .getNotification, responseClass: RinoNotification.self) { notifications, errorcase in
            complition(notifications,errorcase)
        }
    }
    func chnagePassowrd(oldPassword:String,newPassowrd:String,complition:@escaping(ChnagePassowrd?,NetworkErrorCase)->Void){
        fetchData(target: .chnagePassowrd(oldPassword: oldPassword, newPassword: newPassowrd), responseClass: ChnagePassowrd.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func ppSearch(text:String,complition:@escaping(PPSeeAllResponse?,NetworkErrorCase)->Void){
        fetchData(target: .ppSearch(text: text), responseClass:PPSeeAllResponse.self) { payment, errorcase in
            complition(payment,errorcase)
        }
    }
    func hrHome(from:String,filter:String,complition:@escaping(HRHomePageResponse?,NetworkErrorCase)->Void){
        fetchData(target: .hrHome(from: from, filter: filter), responseClass: HRHomePageResponse.self) { hrRequests, errorcase in
            complition(hrRequests,errorcase)
        }
    }
    func confirmEmail(email:String,complition:@escaping(ConfirmEmail?,NetworkErrorCase)->Void){
        fetchData(target: .confirmEmail(email: email), responseClass: ConfirmEmail.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func submitNewPass(email:String,otp:Int,passowrd:String,complition:@escaping(ConfirmEmail?,NetworkErrorCase)->Void){
        fetchData(target: .submitNewPass(email: email, otp: otp, passowrd: passowrd), responseClass: ConfirmEmail.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    
    func getPaymentDetails(id:String,complition:@escaping(PaymentProceesDetailsResponse?,NetworkErrorCase)->Void){
        fetchData(target: .ppdetails(id: id), responseClass: PaymentProceesDetailsResponse.self) { payment, errorcase in
            complition(payment,errorcase)
        }
    }
    
    func chnageApprovalState(path:String,complition:@escaping(PPApproveResponse?,NetworkErrorCase)->Void){
        fetchData(target: .changeApprovalState(path: path), responseClass: PPApproveResponse.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func getClearanceDetails(path:String,complition:@escaping(HRDetailsResponse?,NetworkErrorCase)->Void){
        fetchData(target: .clearanceDetails(path: path), responseClass: HRDetailsResponse.self) { clearanceRequest, errorcase in
            complition(clearanceRequest,errorcase)
        }
    }
    func getComplainst(complition:@escaping([Complian]?,NetworkErrorCase)->Void){
        fetchData(target: .complaints, responseClass: [Complian].self) { complaints, errorcase in
            complition(complaints,errorcase)
        }
    }
    func getUserProfile(complition:@escaping(UserProfile?,NetworkErrorCase)->Void){
        fetchData(target: .userProfile, responseClass: UserProfile.self) { profile, errorcase in
            complition(profile,errorcase)
        }
    }
    func registerDeviceFCM(FCMRegisterToken:String,complition:@escaping(SuccessResponse?,NetworkErrorCase)->Void){
        fetchData(target: .registerFCMToken(FCMRegisterToken: FCMRegisterToken), responseClass: SuccessResponse.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func markNotificationReaded(id:Int,complition:@escaping(SuccessResponse?,NetworkErrorCase)->Void){
        fetchData(target: .markNotificationRead(id: id), responseClass: SuccessResponse.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func getDepartmentsForComplaints(complition:@escaping([String]?,NetworkErrorCase)->Void){
        fetchData(target: .getDepartmentForCompliants, responseClass: [String].self) { departments, errorcase in
            complition(departments,errorcase)
        }
    }
    func getPPSeeAll(url:String,complition:@escaping(PPSeeAllResponse?,NetworkErrorCase)->Void){
        fetchData(target: .ppSeeAll(url: url), responseClass: PPSeeAllResponse.self) { payments, errorcase in
            complition(payments,errorcase)
        }
    }
    func chnageLog(requestID:Int,complition:@escaping(ChangeLog?,NetworkErrorCase)->Void){
        fetchData(target: .changeLog(requestID: requestID), responseClass: ChangeLog.self) { logs, errorcase in
            complition(logs,errorcase)
        }
    }
    func hrSearch(query:String,pageNumber:Int,complition:@escaping(HRSearchResponse?,NetworkErrorCase)->Void){
        fetchData(target: .hrSearch(query: query, pageNumber: pageNumber), responseClass: HRSearchResponse.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func getPermissonState(complition:@escaping(HasPersission?,NetworkErrorCase)->Void){
        fetchData(target: .getPermissionState, responseClass: HasPersission.self) { hasPermission, errorcase in
            complition(hasPermission,errorcase)
        }
    }
    func hrSeeAll(url:String,complition:@escaping(HRSeeAllResponse?,NetworkErrorCase)->Void){
        fetchData(target: .hrSeeAll(path: url), responseClass: HRSeeAllResponse.self) { response, errorcase in
            complition(response,errorcase)
        }
    }
    func getPaymentOrder(filter:String,complition:@escaping(PaymentOrderHomeResponse?,NetworkErrorCase)->Void){
        fetchData(target: .paymentOrder(filter: filter), responseClass: PaymentOrderHomeResponse.self) { paymentOrders, errorcase in
            complition(paymentOrders,errorcase)
        }
    }
    func paymentOrderSearch(query:String,pageNumber:Int,complition:@escaping(PaymentOrderSearchResponse?,NetworkErrorCase)->Void){
        fetchData(target: .paymentOrderSearch(query: query, pageNumber: pageNumber), responseClass: PaymentOrderSearchResponse.self) { orders, errorcase in
            complition(orders,errorcase)
        }
    }
    func getAllPaymentOrder(path:String,complition:@escaping(PaymentOrderSeeAllResponse?,NetworkErrorCase)->Void){
        fetchData(target: .paymentOrderSeeAll(path: path), responseClass: PaymentOrderSeeAllResponse.self) { orders, errorcase in
            complition(orders,errorcase)
        }
    }
    
}
protocol UsersAPIProtocol{
    func logIn(userName:String,password:String,complition:@escaping(UserToken?,NetworkErrorCase)->Void)
}
