//
//  Notification.swift
//  Rino
//
//  Created by Ayman Omara on 10/10/2021.
//

import Foundation
import SwiftUI
class RinoNotification:Codable{
    var data : [NotificationData]?
    var success:Bool?
    var message:String?
}
class NotificationData:Codable,Identifiable {
    var notificationID:Int?
    var requestid:Int?
    var date:String?
    var category,subcategory,body:String?
    var isread:Bool?
    var process:Int?
    var entity:Int?
    private enum CodingKeys:String,CodingKey{
        case notificationID = "id",requestid = "requestid",date = "date",category = "category",subcategory = "subcategory",body = "body",isread = "isread",process,entity
    }
}
