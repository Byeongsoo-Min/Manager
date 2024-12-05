//
//  UserDefaultsManager.swift
//  Manager
//
//  Created by MBSoo on 11/12/24.
//

import Foundation
import UIKit
import SwiftUI

class UserDefaultsManager {
    enum Key: String, CaseIterable{
        case accessToken
    }
    enum Constants: String, CaseIterable {
        case managerName
        case memberId
        case imageKeys = "imageKeys"
        case companyNames = "companyNames"
        case companyNumbers = "companyNumbers"
        case numOfStoredCompany
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
    
    func setConstants(managerName: String, memberId: Int) {
        print("UserDefaultsManager - setConstants() called")
        UserDefaults.standard.set(managerName, forKey: Constants.managerName.rawValue)
        UserDefaults.standard.set(memberId, forKey: Constants.memberId.rawValue)
        
        // Card 저장 수 초기화
        UserDefaults.standard.set(0, forKey: Constants.numOfStoredCompany.rawValue)
        
        UserDefaults.standard.synchronize()
    }
    
    func saveCardImages(imageData: Data){
        print("UserDEfaultsManager - saveCardImage() called")
        let cardIndex = UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue) + 1
        
        let imageKey = "imageKeyNum\(cardIndex)"
        
        UserDefaults.standard.set(imageData, forKey: imageKey)
        UserDefaults.standard.set(cardIndex, forKey: Constants.numOfStoredCompany.rawValue)
        
        var imageKeys = UserDefaults.standard.stringArray(forKey: Constants.imageKeys.rawValue)
        if var imageKeys = imageKeys {
            if !imageKeys.contains(imageKey){
                imageKeys.append(imageKey)
                UserDefaults.standard.set(imageKeys, forKey: Constants.imageKeys.rawValue)
                print("------------saveCardImages----------",imageKeys)
            }
        } else {
            var images: [String] = []
            images.append(imageKey)
            UserDefaults.standard.set(images, forKey: Constants.imageKeys.rawValue)
            print("--------------FirstSaveCardImages--------", images)
        }
        UserDefaults.standard.synchronize()
    }
    
    func saveCardInfos(companyName: String, companyNumber: String){
        var index = UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue) + 1
        let companyNameKey = "\(companyName)\(index)"
        let companyNumberKey = "\(companyNumber)\(index)"
        
        UserDefaults.standard.set(companyName, forKey: companyNameKey)
        UserDefaults.standard.set(companyNumber, forKey: companyNumberKey)
        UserDefaults.standard.set(index, forKey: Constants.numOfStoredCompany.rawValue)
        
        var companyNamesKey = UserDefaults.standard.stringArray(forKey: Constants.companyNames.rawValue)
        var companyNumbersKey = UserDefaults.standard.stringArray(forKey: Constants.companyNumbers.rawValue)
        if var companyNamesKey = companyNamesKey, var companyNumbersKey = companyNumbersKey {
            if !companyNamesKey.contains(companyNameKey){
                companyNamesKey.append(companyNameKey)
                UserDefaults.standard.set(companyNamesKey, forKey: Constants.companyNames.rawValue)
            } else {
               var companyNames: [String] = []
               companyNames.append(companyNameKey)
                UserDefaults.standard.set(companyNames, forKey: Constants.companyNames.rawValue)
           }
            if !companyNumbersKey.contains(companyNumberKey){
                companyNumbersKey.append(companyNumberKey)
                UserDefaults.standard.set(companyNumbersKey, forKey: Constants.companyNumbers.rawValue)
            } else {
                var companyNumbers: [String] = []
                companyNumbers.append(companyNumberKey)
                UserDefaults.standard.set(companyNumbers, forKey: Constants.companyNumbers.rawValue)
            }
        }
        UserDefaults.standard.synchronize()
    }
    
// 토큰들 가져오기
    /*JWT 토큰 발급 받을 시 사용할 함수*/
//    func getTokens()->TokenData{
//        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
//        return TokenData(accessToken: accessToken)
//    }
    
    // ManagerName 받기
    func getManagerName()->String {
        let managerName = UserDefaults.standard.string(forKey: Constants.managerName.rawValue) ?? ""
        return managerName
    }
    // MemeberId 받기
    func getMemeberId()-> Int {
        let memberId = UserDefaults.standard.integer(forKey: Constants.memberId.rawValue) 
        return memberId
    }
    // CardImage 와 키들 한번에 받기
    func getCardImagesWithKeys()-> [String: UIImage] {
        var images: [String : UIImage] = [:]
        if let imageKeys = UserDefaults.standard.stringArray(forKey: Constants.imageKeys.rawValue) {
            for imageKey in imageKeys {
                if let imageData = UserDefaults.standard.data(forKey: imageKey), let image = UIImage(data: imageData) {
                    images[imageKey] = image
                }
            }
        }
        return images
    }
    // 모든 cardImage 받기
    func getAllCardImages()-> [UIImage]? {
        print("-------------Active Get Card Images By Int ---------------")
        var images: [UIImage] = []
        if let imageKeys = UserDefaults.standard.stringArray(forKey: Constants.imageKeys.rawValue) {
            print(imageKeys)
            for imageKey in imageKeys {
                if let imageData = UserDefaults.standard.data(forKey: imageKey), let image = UIImage(data: imageData) {
                    images.append(image)
                    
                }
            }
            print("-------------Successfully Get Images ---------------", images.count)
        }
        return images
    }
    // 원하는 카드 이미지 index를 통해서 받아오기
    func getCardImageByIdx(idx: Int) -> UIImage {
        print("Get Card Image")
        var cardImage = UIImage()
        if let imageKeys = UserDefaults.standard.stringArray(forKey: Constants.imageKeys.rawValue) {
            for imageKey in imageKeys {
                if (imageKey == "image\(idx)") {
                    if let imageData = UserDefaults.standard.data(forKey: imageKey), let image = UIImage(data: imageData) {
                        cardImage = image
                    }
                }
            }
        }
        return cardImage;
    }
    // 원하는 회사 정보 index를 통해서 받아오기
    func getCardCompanyInfoByIdx(idx: Int)->[String] {
        var infos: [String] = []
        if let companyNameKeys = UserDefaults.standard.stringArray(forKey: Constants.companyNames.rawValue) {
            for companyNameKey in companyNameKeys {
                if (companyNameKey == "companyName\(idx)") {
                    if let companyName = UserDefaults.standard.string(forKey: companyNameKey) {
                        infos.append(companyName)
                    }
                }
            }
        }
        if let companyNumberKeys = UserDefaults.standard.stringArray(forKey: Constants.companyNumbers.rawValue) {
            for companyNumberkey in companyNumberKeys {
                if(companyNumberkey == "companyNumber\(idx)") {
                    if let companyNumber = UserDefaults.standard.string(forKey: companyNumberkey) {
                        infos.append(companyNumber)
                    }
                }
            }
        }
        return infos
    }
    // 저장한 idx에 맞춰서 저장된 모든 카드 가져옴
    func getAllStoredCard() -> [Card] {
        var cardList: [Card] = []
        if let companyNameKeys = UserDefaults.standard.stringArray(forKey: Constants.companyNames.rawValue), let companyNumberKeys = UserDefaults.standard.stringArray(forKey: Constants.companyNumbers.rawValue), let imageKeys = UserDefaults.standard.stringArray(forKey: Constants.imageKeys.rawValue) {
            for idx in Array(0..<UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue)) {
                if let companyName = UserDefaults.standard.string(forKey: companyNameKeys[idx]), let companyNumber = UserDefaults.standard.string(forKey: companyNumberKeys[idx]), let image = UserDefaults.standard.data(forKey: imageKeys[idx]) {
                    let base64Encode = image.base64EncodedString()
                    let card = Card(companyName: companyName, companyNumber: companyNumber, imageBase64: base64Encode, cardId: idx)
                    cardList.append(card)
                }
            }
        }
        return cardList
    }
}
