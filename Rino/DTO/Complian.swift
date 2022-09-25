//
//  Complian.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import Foundation
import SwiftUI
class Complian:Codable,Identifiable{
    var department,body,officer,createdAt:String
    var attchements :[ComplianAttachments]?
}
class ComplianAttachments:Codable,Identifiable{
    var name,url:String?
}
