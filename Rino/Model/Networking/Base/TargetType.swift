//
//  TargetType.swift
//  Rino
//
//  Created by Ayman Omara on 09/07/2022.
//

import Foundation
import Alamofire
enum HTTPMethod:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
enum Task{
    case resquestPlain
    case requestParameter(paramters:[String:Any],encoding:ParameterEncoding)
}
protocol TargetType{
    var baseURL:String {get}
    var path:String {get}
    var method:HTTPMethod {get}
    var task:Task {get}
    var headers:[String:String]?{get}
}
