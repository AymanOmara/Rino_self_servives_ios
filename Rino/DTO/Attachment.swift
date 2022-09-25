//
//  Attachment.swift
//  Rino
//
//  Created by Ayman Omara on 07/06/2022.
//

import Foundation
import UIKit
import SwiftUI
class Attachment:Codable,Identifiable{
    var username,jobTitle,date,name,url:String?
}
struct CreateAttachmentRequest{
    let attatchments :[UploadableFile]
    let requestId,RequestType:Int
}
class UploadableFile:Identifiable{
    var fileExtension,fileName:String
    var file:Data
    var image:UIImage
    init(fileExtension:String,fileName:String,file:Data,image:UIImage){
        self.fileExtension = fileExtension
        self.fileName = fileName
        self.file = file
        self.image = image
        
    }
}

