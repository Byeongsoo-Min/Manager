//
//  UserViewModel.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation
import Alamofire

class UserViewModel: ObservableObject {
    let baseUrl = APIClient.BASE_URL + "member/"
    let session: Session = {
        let interceptor = BaseInterceptor()
        let configuration = URLSessionConfiguration.default
        return Session(configuration: configuration, interceptor: interceptor)
    }()
    var managerName: String?
    var memberId: Int?
    
    func signUp(manager_name: String){
        let urlString = baseUrl + "signup"
        guard let url = URL(string: urlString) else {
            print("error has occured in converting URL")
            return
        }
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        let parameters: [String: Any] = [
            "manager_name": manager_name
        ]
        let headers: HTTPHeaders = [
                "Content-Type": "application/json",
            ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: AuthResponse.self, completionHandler: { response in
                    switch response.result {
                    case .success(let response):
                        print(response)
                        self.managerName = response.manager_name
                        self.memberId = response.member_id
                        UserDefaultsManager.shared.setConstants(managerName: manager_name, memberId: self.memberId ?? 2)
                    case .failure(let error):
                        print(error.responseCode)
                        print(error)
                    }
                })
    }
    
}
