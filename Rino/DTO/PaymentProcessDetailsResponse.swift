//
//  PaymentProcessDetailsResponse.swift
//  Rino
//
//  Created by Ayman Omara on 07/06/2022.
//

import Foundation
class PaymentProceesDetailsResponse:Codable{
    var success:Bool?
    var message:String?
    var data:PaymentProcessData?
}
class PaymentProcessData:Codable{
    var id:Int?
    var date,department,provision,desc:String?
    var amount,limit,balance:Double?
    var paytype,beneficiary:String?
    var action:PaymentProcessDetailsAction?
    var status,status_code,status_date,status_by:String?
    var step:Int?
    var current:Current?
    var attachments:[Attachment]?
    var hasPermission,hasMadeAction:Bool?
}
class PaymentProcessDetailsAction:Codable{
    var name,since:String?
    var users:[String]?
    var cancel,valid:Bool?
}
