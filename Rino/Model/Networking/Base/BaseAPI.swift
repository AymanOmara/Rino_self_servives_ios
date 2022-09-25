//
//  BaseAPI.swift
//  Rino
//
//  Created by Ayman Omara on 09/07/2022.
//

import Foundation
import Alamofire
class BaseAPI<T:TargetType>{
    func fetchData<M: Codable>(target:T,responseClass:M.Type,complition:@escaping(M?,NetworkErrorCase)->Void) {
        if !Connectivity.isConnectedToInternet{
            complition(nil,.noConntection)
            return
        }
        print(target.baseURL+target.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.request(target.baseURL+target.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,method: method,parameters: params.0,encoding: params.1,headers: headers).responseDecodable(of: M.self){
            [weak self] response in
            switch response.result{
                
            case .success(_):

                print(response.response?.statusCode)
                complition(response.value, .none)

            case .failure(let error):
                guard let self = self else{return}
                print(response.response?.statusCode)
                print(error.localizedDescription)

                if response.response?.statusCode == 401{
                    Network.shared.refreshToken { userToken in
                        if let _ = userToken?.access_token , let _ = userToken?.refresh_token {
                            self.fetchData(target: target, responseClass: M.self, complition: { response, errorCase in
                                complition(response,errorCase)
                            })
                        }else{
                            complition(nil,.timeOut)
                        }
                    }
                }else{
                    let errorCase = self.getErrorType(errorMessage: error.localizedDescription, statusCode: response.response?.statusCode)
                    print(errorCase)
                    complition(nil,errorCase)
                }
            }
        }
    }
    private func buildParams(task:Task) -> ([String:Any],ParameterEncoding){
        switch task {
        case .resquestPlain:
            return ([:],URLEncoding.default)
        case .requestParameter(let paramters, let encoding):
            return (paramters,encoding)
        }
    }
    private func getErrorType(errorMessage:String,statusCode:Int?)-> NetworkErrorCase{
        if errorMessage.contains("offline") == true{
            return .noConntection
        }else if errorMessage.contains("time out") == true{
            return  .timeOut
        }else if statusCode == 500{
            return .serverError
        }else{
            return .timeOut
        }
    }
}
