//
//  AllServicesViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 02/08/2022.
//

import Foundation
import Combine
class AllServicesViewModel:ObservableObject{
    @Published var shouldOpenNotification = false
    @Published var isLoading = false
    @Published var errorcase = NetworkErrorCase.none
    @Published var isGM:Bool?
    func getPrivillage(isFromNotification:Bool){
        errorcase = NetworkErrorCase.none
        isLoading = true
        UsersAPI.shard.getPermissonState {[weak self] permission, errorcase in
            guard let self = self else {return}
           self.isLoading = false
            if let  permission = permission{
                self.isGM = permission.isGM
            }else{
                self.errorcase = errorcase
            }
            if isFromNotification{
                self.shouldOpenNotification = true
            }
        }
    }
}
