//
//  NetworkErrors.swift
//  Rino
//
//  Created by Ayman Omara on 12/07/2022.
//

import Foundation
enum NetworkErrorCase:String{
    case none = ""
    case noConntection = "لا يوجد اتصال الانترنت"
    case timeOut = "حدث خطا الرجاء المحاوله في وقت لاحق"
    case serverError = "internal server error please try again later"
    case emptyData = "عفوا لا تتوافر بيانات لعرضها"
}
