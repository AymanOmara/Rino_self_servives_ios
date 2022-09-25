//
//  PPApproveResponse.swift
//  Rino
//
//  Created by Ayman Omara on 23/06/2022.
//

import Foundation
struct PPApproveResponse:Codable{
    var data:PPApproveData?
    var message:String?
    var success:Bool?
}
struct PPApproveData:Codable{
    var current:Current
    var status_date:String
    var status:String
    var step:Int
}
