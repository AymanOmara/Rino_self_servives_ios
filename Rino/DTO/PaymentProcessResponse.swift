//
//  PaymentProcessResponse.swift
//  Rino
//
//  Created by Ayman Omara on 30/08/2021.
//

import Foundation
import SwiftUI
class PaymentProcessResponse: Codable {
    var data: [PPData]?
    var success: Bool?
    var message: String?
}
class PPData:Codable,Identifiable {
    var title,start,end:String?
    var count:Int?
    var items:[Item]?
}
class Item:Codable,Identifiable{
    var entity:Int?
    var requestID: Int?
    var start,end,paymentmethod:String?
    var code,reason,type:String?
    var date, department: String?
    var status,status_code,employee: String?
    var step: Int?
    var status_date, status_by: String?
    var action: Action?
    var current: Current?
    var amount,balance: Double?
    private enum CodingKeys:String,CodingKey{
    case entity,start,end,code,reason,type,requestID = "id",date,department,status,status_code,employee,step,status_date,status_by,action,current,amount
    }
}
class Action: Codable {
    var name: String?
    var since: String?
    var cancel, valid: Bool?
    var users: [String]?
}
class Current:Codable {
    var name:String?
    var users:[String]?
}
