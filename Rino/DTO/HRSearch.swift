//
//  HRSearch.swift
//  Rino
//
//  Created by Ayman Omara on 05/07/2022.
//

import Foundation
import SwiftUI
struct HRSearchResponse:Codable{
    var data:[HRSearchData]?
    var total:Int?
    var success:Bool?
    var message:String?
}
class HRSearchData:Codable,Identifiable{
    var id,step,entity:Int?
    var date,department,status_code,status,status_datestatus_by:String?
    var action:Action?
    var current:Current?
    var start,end,employee,code,reason,type:String?
    var me:Bool?
}
