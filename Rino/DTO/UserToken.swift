//
//  User.swift
//  Rino
//
//  Created by Ayman Omara on 29/08/2021.
//

import Foundation
struct UserToken:Codable {
    let error,error_description:String?
    let access_token,token_type,refresh_token:String?
}
