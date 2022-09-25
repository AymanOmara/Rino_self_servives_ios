//
//  ChosenAttachment.swift
//  Rino
//
//  Created by Ayman Omara on 21/06/2022.
//

import Foundation
import SwiftUI
class ChosenAttachments:Identifiable{
    var id = UUID()
    var image:UIImage?
    var attachmentName,attachmentType:String
    var data:Data?
    init(image:UIImage?,attachmentName:String,attachmentType:String,fileData:Data?){
        self.image = image
        self.attachmentName = attachmentName
        self.attachmentType = attachmentType
        self.data = fileData
    }
}
