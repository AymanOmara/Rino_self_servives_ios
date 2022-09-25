//
//  ViewCompliantsViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import Foundation
import Combine
class ViewCompliantsViewModel:ObservableObject{
    @Published var hasePerssion:Bool?
    @Published var isLoading = false
    @Published var hasError = false
    @Published var complians = [Complian]()
    @Published var errorcase = NetworkErrorCase.none
    
    //    private var network = Network.shared
    func getPersissionState(){
        errorcase = NetworkErrorCase.none
        isLoading = true
        UsersAPI.shard.getPermissonState {[weak self] response, errorcase in
            guard let self = self else{return}
            if errorcase == .none{
                guard let response = response else{
                    self.errorcase = .timeOut
                    return
                }
                if response.isDepartmentHead || response.isGM{
                    self.hasePerssion = true
                    self.getAllCompliants()
                }else{
                    self.hasePerssion = false
                    self.isLoading = false
                }
            }else{
                self.errorcase = errorcase
            }
        }
    }
    
    func getAllCompliants(){
        errorcase = NetworkErrorCase.none
        UsersAPI.shard.getComplainst {[weak self] compliants, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase == .none{
                guard let compliants = compliants else{
                    self.errorcase = .emptyData
                    return
                }
                self.complians = compliants
            }else{
                self.errorcase = errorcase
            }
        }
    }
}
