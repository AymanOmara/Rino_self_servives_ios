//
//  UserProfileViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 29/06/2022.
//

import Foundation
class UserProfileViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var errorcase = NetworkErrorCase.none
    @Published var data:UserProfile?
    func getUserProfile(){
        isLoading = true
        UsersAPI.shard.getUserProfile {[weak self] profile, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                guard let profile = profile else{
                    self.errorcase = .emptyData
                    return
                }
                self.data = profile
            }else{
                self.errorcase = errorcase
            }
        }
    }
}
protocol RefreshToken{
    func refreshToken(complition:@escaping(()->()))
}
extension RefreshToken{
    func refreshToken(complition:@escaping(()->())){
        Network.shared.refreshToken { userToken in
            if let token = userToken?.access_token , let refresh = userToken?.refresh_token {
                complition()
            }
        }
    }
}
