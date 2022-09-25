//
//  NotificationCount.swift
//  Rino
//
//  Created by Ayman Omara on 13/12/2021.
//

import Foundation
class NotificationCount:Codable{
    var data:NotificationCountData?
    var success:Bool?
    var message:String?
}
class NotificationCountData:Codable{
    var paymentNotifies,clearanceNotifies,orderNotifies:Int?
}
