//
//  Connectivity.swift
//  Rino
//
//  Created by Ayman Omara on 02/09/2021.
//
//MARK:- This class is only about checking if there is internet connection 
import Foundation
import Alamofire
struct Connectivity {

    private init() {}
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
