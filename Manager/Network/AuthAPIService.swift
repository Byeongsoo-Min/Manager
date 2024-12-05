//
//  AuthAPIService.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation
import Alamofire
import Combine

// 인증 관련 api 호출
enum AuthAPIService {
    
    // 회원가입
    static func register(name: String, email: String, password: Int) -> AnyPublisher<AuthResponse, AFError>{
        print("AuthApiService - register() called")
        
        return APIClient.shared.session
            .request(AuthRouter.register(name: name, email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults, keychain
//                UserDefaultsManager.shared.setTokens(accessToken: receivedValue.token)
//                UserDefaultsManager.shared.setConstants(clubName: receivedValue.clubName)
                return receivedValue
            }.eraseToAnyPublisher()
    }
    
    // 로그인
    static func login(email: String, password: Int) -> AnyPublisher<AuthResponse, AFError>{
        print("AuthApiService - register() called")
        
        return APIClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults, keychain
//                UserDefaultsManager.shared.setTokens(accessToken: receivedValue.token)
//                UserDefaultsManager.shared.setConstants(clubName: receivedValue.clubName)
                return receivedValue
            }.eraseToAnyPublisher()
    }
    
}
