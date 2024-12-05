//
//  BaseIntercepter.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation
import Alamofire
import Combine

final class BaseInterceptor: RequestInterceptor {
    
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        
        // 헤더 부분 넣어주기
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        completion(.success(request))
    }
}
