//
//  SettingsViewModel.swift
//  Rino
//MARK:- This class is Responsible for connecting the UI To Model Layer (For Settings)
//  Created by Ayman Omara on 07/09/2021.
//

import Foundation
class SettingsViewModel {
   private let localModel = LocalModel.shared
    func logOut() {
        localModel.setToken(token: "", refreshToken: "")
    }
}
