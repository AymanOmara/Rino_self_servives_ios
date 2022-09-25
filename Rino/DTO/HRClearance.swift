//
//  HRClearance.swift
//  Rino
//
//  Created by Ayman Omara on 03/10/2021.
//

import Foundation
import SwiftUI
class ClearanceItem:Codable {
    var id: Int?
    var vacationDuration:String?
    var date, department,paytype,beneficiary,limit,provision,desc: String?
    var status,status_code: String?
    var step: Int?
    var status_date, status_by: String?
    var action: Action?
    var current: Current?
    var amount: Double?
    var employee:String?
    var employee_id:Int?
    var title, start, end: String?
    var count: Int?
    var code,reason,type:String?
    var items: [Item]?
    var balance:Double?
    
}
struct HRSeeAllResponse:Codable{
    var data:[HRSeeAllData]?
    var total:Int?
    var message:String?
    var success:Bool?
}
class HRSeeAllData:Codable,Identifiable{
    var id,step,entity:Int?
    var date,department,status_code,status,status_datestatus_by:String?
    var action:Action?
    var current:Current?
    var start,end,employee,code,reason,type:String?
    
}
struct HRHomePageResponse:Codable{
    var data:[HRHomePageData]?
    var success:Bool?
    var message:String?
}
class HRHomePageData:Codable,Identifiable{
    var title,start,end:String?
    var count:Int?
    var items:[Item]?
}
