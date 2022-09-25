//
//  SearchViewModel.swift
//  Rino
//
//  Created by Ayman Omara on 29/09/2021.
//

import Foundation
import Combine
class PPSearchViewModel:ObservableObject{
    
    @Published var message =  ""
    @Published var items = [PaymentItem]()
    @Published var isLoading = false
    @Published var errorcase = NetworkErrorCase.none
    func getData(text:String) {
        isLoading = true
        items.removeAll()
        errorcase = .none
        UsersAPI.shard.ppSearch(text: text.toEnglishNumber()) {[weak self] items, errorcase in
            guard let self = self else{return}
            self.isLoading = false
            if errorcase !=  .none{
                self.errorcase = errorcase

            }else{
                if let items = items{
                    if items.success == false || items.data?.isEmpty == true{
                        self.errorcase = .emptyData
                    }else{
                        self.items.append(contentsOf: items.data ?? [])
                    }
                }
            }
        }
    }
}
