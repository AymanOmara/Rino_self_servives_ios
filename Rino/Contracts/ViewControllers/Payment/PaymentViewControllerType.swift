//
//  PaymentViewControllerType.swift
//  Rino
//
//  Created by Ayman Omara on 15/09/2021.
//

import Foundation
protocol PaymentViewControllerType: BaseViewController {
    var data:PaymentProcessResponse?{get}
    
    func onSuccess()
    func onFail()
    func tableConfiguration()
    func dropConfiguration()
    func moveToSeeAllVC(strat:String,end:String)
}
