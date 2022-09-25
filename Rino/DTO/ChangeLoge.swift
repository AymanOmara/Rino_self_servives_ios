//
//  ChangeLog.swift
//  Rino
//
//  Created by ARG on 03/07/2022.
//

import Foundation
import SwiftUI
struct ChangeLog:Codable{
    var data:[ChnageLogItem]?
    var status:Bool?
    var message:String?
}
class ChnageLogItem:Codable,Identifiable{
    var requestId,employeeId:Int?
    var oldAmount,newAmount:Double?
    var createdAt,employeeName,departmentName:String?
}
