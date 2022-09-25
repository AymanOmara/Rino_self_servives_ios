//
//  ClearanceDetailsResponse.swift
//  Rino
//
//  Created by Ayman Omara on 08/06/2022.
//

import Foundation
class HRDetailsResponse:Codable{
    var data:HRClearanceData?
    var success:Bool?
    var message:String?
}
class HRClearanceData:Codable{
    var id,employee_id:Int?
    var date,department,reason,start,end,employee,code:String?
    var action:HRClearanceDetailsAction?
    var status_code,status,status_date,status_by,type:String?
    var entity,step:Int?
    var current:Current?
    var attachments:[Attachment]?
    var hasApprovedRequest,hasPermission:Bool?
}
class HRClearanceDetailsAction:Codable{
    var name,since:String?
    var cancel,valid:Bool?
    var users:[String]?
}
//class HRClearanceCurrent:Codable{
//    var name:String?
//    var users:[String]?
//}
