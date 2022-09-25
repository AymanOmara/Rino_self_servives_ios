//
//  PaymentOrderSeeAll.swift
//  Rino
//
//  Created by Ayman Omar on 14/08/2022.
//

import Foundation
class PaymentOrderSeeAllResponse:Codable{
    var data:[PaymentOrderItem]?
    var count:Int?
    var success:Bool?
    var message:String?
}
