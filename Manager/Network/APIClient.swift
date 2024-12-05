//
//  APIClient.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation

import Alamofire

final class APIClient {
    
    static let shared = APIClient()
    
    //Local test 주소
    static let BASE_URL = "http://www.managerchatgpt.shop:8080/api/v1/"
    
    // 서버 배포시 사용할 주소
//    static let BASE_URL = ""
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
}
