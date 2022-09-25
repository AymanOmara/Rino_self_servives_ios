//
//  PPSeeAllResponse.swift
//  Rino
//
//  Created by Ayman Omar on 23/06/2022.
//

import Foundation
import SwiftUI
struct PPSeeAllResponse:Codable{
    var data:[PaymentItem]?
    var total:Int?
    var message:String?
    var success:Bool?
}
struct PaymentItem:Codable,Identifiable{
    var id:Int?
    var amount,balance:Double?
    var beneficiary,status:String?
    var date:String?
    var department:String?
    var status_code:String?
    var current:Current?
    var payType:String?
    var me:Bool?
}
