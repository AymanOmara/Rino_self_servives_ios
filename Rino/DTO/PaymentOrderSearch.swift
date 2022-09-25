//
//  PaymentOrderSearch.swift
//  Rino
//
//  Created by Ayman Omara on 14/08/2022.
//

import SwiftUI
class PaymentOrderSearchResponse:Codable{
    var data:[PaymentOrderItem]?
    var count:Int?
    var success:Bool?
    var message:String?
}
