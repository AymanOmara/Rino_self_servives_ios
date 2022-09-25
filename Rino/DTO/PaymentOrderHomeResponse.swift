//
//  PaymentOrderHomeResponse.swift
//  Rino
//
//  Created by Ayman Omara on 08/08/2022.
//

import Foundation
import SwiftUI
class PaymentOrderHomeResponse:Codable{
    let data:[PaymentOrderHomeData]?
    let success:Bool?
    let message:String?
}
class PaymentOrderHomeData:Identifiable,Codable{
    var title,from,to:String?
    var count:Int?
    var items:[PaymentOrderItem]?
}
class PaymentOrderItem:Codable,Identifiable{
    var requestID,status:Int?
    var status_date:String?
    var custom_data:PaymentOrderCustomeData?
    private enum CodingKeys:String,CodingKey{
        case requestID = "id",status,status_date,custom_data
    }
}
struct PaymentOrderCustomeData:Codable{
    var details,beneficiary:String?
    var amount:Double?
}
