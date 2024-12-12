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
        case companyHastTags
        case userChatHistory
        case gptChatHistory
        case numOfStoredChat
        case numOfStoredCompany
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    struct CompanyInfo {
        var image: UIImage
        var companyNameNum: [String]
        var companyHashTag: [String]
    }
    
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
        // Chat 저장 수 초기화
        UserDefaults.standard.set(0, forKey: Constants.numOfStoredChat.rawValue)
        
        UserDefaults.standard.synchronize()
    }
    
    func saveCardImage(imageData: Data){
        print("UserDEfaultsManager - saveCardImage() called")
        let cardIndex = UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue)
        
        let imageKey = "image\(cardIndex)"
        
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
        var index = UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue)
        let companyNameKey = "companyName\(index)"
        let companyNumberKey = "companyNumber\(index)"
        
        UserDefaults.standard.set(companyName, forKey: companyNameKey)
        UserDefaults.standard.set(companyNumber, forKey: companyNumberKey)
        
        var companyNamesKey = UserDefaults.standard.stringArray(forKey: Constants.companyNames.rawValue)
        var companyNumbersKey = UserDefaults.standard.stringArray(forKey: Constants.companyNumbers.rawValue)
        // companyNamesKey가 nil, 즉 처음 저장될때를 대비함
        if var companyNamesKey = companyNamesKey {
            if !companyNamesKey.contains(companyNameKey){
                // 처음 저장되는 것일 경우 (근데 터질 일이 없는 if 문임)
                companyNamesKey.append(companyNameKey)
                UserDefaults.standard.set(companyNamesKey, forKey: Constants.companyNames.rawValue)
                print("------------save Company Name----------",companyNamesKey)
            }
        } else {
            // 처음 Key를 저장할때
            var companyNames: [String] = []
            companyNames.append(companyNameKey)
             UserDefaults.standard.set(companyNames, forKey: Constants.companyNames.rawValue)
            print("------------First Save Company Name----------",companyNames)
        }
        
        if var companyNumbersKey = companyNumbersKey {
            if !companyNumbersKey.contains(companyNumberKey){
                companyNumbersKey.append(companyNumberKey)
                UserDefaults.standard.set(companyNumbersKey, forKey: Constants.companyNumbers.rawValue)
                print("------------save Company Number----------",companyNumbersKey)
            }
        } else {
            var companyNumbers: [String] = []
            companyNumbers.append(companyNumberKey)
            UserDefaults.standard.set(companyNumbers, forKey: Constants.companyNumbers.rawValue)
            print("------------First Save Company Number----------",companyNumbers)
        }
        UserDefaults.standard.synchronize()
    }
    
    func saveCompanyHashTags(messages: String) {
        var index = UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue)
        let companyHashTagKey = "hashTag\(index)"
        
        UserDefaults.standard.set(messages, forKey: companyHashTagKey)
        
        var hashTagKeys = UserDefaults.standard.stringArray(forKey: Constants.companyHastTags.rawValue)
        
        if var hashTagKeys = hashTagKeys {
            if !hashTagKeys.contains(companyHashTagKey){
                // 처음 저장되는 것일 경우 (근데 터질 일이 없는 if 문임)
                hashTagKeys.append(companyHashTagKey)
                UserDefaults.standard.set(hashTagKeys, forKey: Constants.companyHastTags.rawValue)
                print("------------save hashTag ----------",hashTagKeys)
            }
        } else {
            // 처음 Key를 저장할때
            var hashTags: [String] = []
            hashTags.append(companyHashTagKey)
             UserDefaults.standard.set(hashTags, forKey: Constants.companyHastTags.rawValue)
            print("------------First Save hashTag----------",hashTags)
        }
        UserDefaults.standard.set(index + 1, forKey: Constants.numOfStoredCompany.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func saveUserChat(message: String) {
        let index = UserDefaults.standard.integer(forKey: Constants.numOfStoredChat.rawValue)
        let userChatKey = "user\(index)"
        
        UserDefaults.standard.set(message, forKey: userChatKey)
        UserDefaults.standard.set(index, forKey: Constants.numOfStoredChat.rawValue)
        
        var userChatKeys = UserDefaults.standard.stringArray(forKey: Constants.userChatHistory.rawValue)
        
        if var userChatKeys = userChatKeys {
            if !userChatKeys.contains(userChatKey) {
                userChatKeys.append(userChatKey)
                UserDefaults.standard.set(userChatKeys, forKey: Constants.userChatHistory.rawValue)
                print("------------save User Chat----------",userChatKeys)
            }
        } else {
            var userChats: [String] = []
            userChats.append(userChatKey)
            UserDefaults.standard.set(userChats, forKey: Constants.userChatHistory.rawValue)
            print("------------First Save User Chat----------",userChats)
        }
        UserDefaults.standard.synchronize()
    }
    
    func saveGptChats(message: String) {
        let index = UserDefaults.standard.integer(forKey: Constants.numOfStoredChat.rawValue) + 1
        let gptChatKey = "gpt\(index)"
        
        UserDefaults.standard.set(message, forKey: gptChatKey)
        UserDefaults.standard.set(index, forKey: Constants.numOfStoredChat.rawValue)
        
        var gptChatKeys = UserDefaults.standard.stringArray(forKey: Constants.gptChatHistory.rawValue)
        
        if var gptChatKeys = gptChatKeys {
            if !gptChatKeys.contains(gptChatKey) {
                gptChatKeys.append(gptChatKey)
                UserDefaults.standard.set(gptChatKeys, forKey: Constants.gptChatHistory.rawValue)
                print("------------save Gpt Chat----------",gptChatKeys)
            }
        } else {
            var gptChats: [String] = []
            gptChats.append(gptChatKey)
            UserDefaults.standard.set(gptChats, forKey: Constants.gptChatHistory.rawValue)
            print("------------First Save Gpt Chat----------",gptChats)
        }
        UserDefaults.standard.synchronize()
    }
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
        return cardImage
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
    // 저장된 해쉬태그 불러오기
    func getCompanyHashTags(idx: Int) -> [String] {
        var hashTags: [String] = []
        if let hashTagKeys = UserDefaults.standard.stringArray(forKey: Constants.companyHastTags.rawValue) {
            for hashTagKey in hashTagKeys {
                if (hashTagKey == "hashTag\(idx)") {
                    if let message = UserDefaults.standard.string(forKey: hashTagKey) {
                        for hashTag in message.split(separator: " ") {
                            hashTags.append(String(hashTag))
                        }
                    }
                }
            }
        }
        return hashTags
    }
    // 저장한 idx에 맞춰서 저장된 모든 카드 가져옴
    func getAllStoredCard() -> [Card] {
        var cardList: [Card] = []
        if let companyNameKeys = UserDefaults.standard.stringArray(forKey: Constants.companyNames.rawValue), let companyNumberKeys = UserDefaults.standard.stringArray(forKey: Constants.companyNumbers.rawValue), let imageKeys = UserDefaults.standard.stringArray(forKey: Constants.imageKeys.rawValue) {
            for idx in Array(0..<UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue)) {
                if let companyName = UserDefaults.standard.string(forKey: companyNameKeys[idx]), let companyNumber = UserDefaults.standard.string(forKey: companyNumberKeys[idx]), let image = UserDefaults.standard.data(forKey: imageKeys[idx]) {
                    let base64Encode = image.base64EncodedString()
                    let card = Card(companyName: companyName, companyNumber: companyNumber, image: base64Encode, cardId: idx)
                    cardList.append(card)
                }
            }
        }
        return cardList
    }
    // 각 인덱스에 맞춰서 User, Gpt가 적혀있는 딕셔너리 반환
    // Key: User\(idx), Gpt\(idx) / Value: Chatting 내용
    func getAllChats() -> [String:String] {
        var chatList: [String: String] = [:]
        if let userChatKeys = UserDefaults.standard.stringArray(forKey: Constants.userChatHistory.rawValue), let gptChatKeys = UserDefaults.standard.stringArray(forKey: Constants.gptChatHistory.rawValue) {
            print(">>>>>>>>>>>>>USERCHATKEYS<<<<<<<<<<<<<<<<",userChatKeys)
            print(">>>>>>>>>>>>>GPTCHATKEYS<<<<<<<<<<<<<<<<",gptChatKeys)
            for idx in Array(0..<UserDefaults.standard.integer(forKey: Constants.numOfStoredChat.rawValue)) {
                if let userChat = UserDefaults.standard.string(forKey: userChatKeys[idx]), let gptChat = UserDefaults.standard.string(forKey: gptChatKeys[idx]) {
                    chatList["user\(idx)"] = userChat
                    chatList["gpt\(idx)"] = gptChat
                }
            }
        }
        return chatList
    }
    
    func getCompanyInfos(pageIdx: Int) -> CompanyInfo {
        print(">>>>>>>>>>>>>>>>>>NumOfStoredCompany<<<<<<<<<<<<<<",UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue))
        let companyNameNum: [String] = self.getCardCompanyInfoByIdx(idx: pageIdx)
        let companyImage: UIImage = self.getCardImageByIdx(idx: pageIdx)
        let companyHashTags: [String] = self.getCompanyHashTags(idx: pageIdx)
        
        return CompanyInfo(image: companyImage, companyNameNum: companyNameNum, companyHashTag: companyHashTags)
    }
    
    func getAllCardsInfos() -> [CompanyInfo] {
        var result: [CompanyInfo] = []
        let numOfCards = UserDefaults.standard.integer(forKey: Constants.numOfStoredCompany.rawValue)
        for idx in Array(0..<numOfCards) {
            result.append(self.getCompanyInfos(pageIdx: idx))
        }
        return result
    }
}
