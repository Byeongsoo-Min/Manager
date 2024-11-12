//
//  UserDefaultsManager.swift
//  Manager
//
//  Created by MBSoo on 11/12/24.
//

import Foundation

class UserDefaultsManager {
    enum Key: String, CaseIterable{
        case accessToken
    }
    enum Constants: String, CaseIterable {
        case managerName
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    // 저장된 모든 데이터 지우기
    func clearAll(){
        print("UserDefaultsManager - clearAll() called")
        Key.allCases.forEach{ UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
    
    // 토큰들 저장
    func setTokens(accessToken: String){
        print("UserDefaultsManager - setTokens() called")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setConstants(managerName: String) {
        print("UserDefaultsManager - setConstants() called")
        UserDefaults.standard.set(managerName, forKey: Constants.managerName.rawValue)
        UserDefaults.standard.synchronize()
    }
    
// 토큰들 가져오기
    /*JWT 토큰 발급 받을 시 사용할 함수*/
//    func getTokens()->TokenData{
//        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
//        return TokenData(accessToken: accessToken)
//    }
    
    func getManagerName()->String {
        let managerName = UserDefaults.standard.string(forKey: Constants.managerName.rawValue) ?? ""
        return managerName
    }
}
