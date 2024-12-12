//
//  ConverstaionViewModel.swift
//  Manager
//
//  Created by MBSoo on 12/6/24.
//

import Foundation
import UIKit
import SwiftUI
import Alamofire


class ConverstaionViewModel: ObservableObject {
    @Published var contentList: [ChatResponse]?
    @Published var chatList: [String: String]?
    
    var chatIdx = 0
    var BASE_URL = APIClient.BASE_URL
    var BASE_PARAMETERS = ChatRequestModel(model: "gpt-3.5-turbo", messages: [], member_id: UserDefaultsManager.shared.getMemeberId())
    
    
    init() {
        self.chatList = UserDefaultsManager.shared.getAllChats()
        self.chatIdx = (chatList?.count ?? 0)/2
    }
    
    func setMessage(message: String) {
        var messages: [Message] = []
        messages.append(Message(role: "system", content: "Store each business card that is provided along with its tags. For every subsequent query:- Analyze the query for relevant keywords or details. - Retrieve the most appropriate business card based on the matches between the query and stored information. Respond only based on this data. Do not invent or create new information. When the user asks about a person, find the best match in the data and provide their details in Korean. The user's response is divided into #. Answer in korean."))
        messages.append(Message(role: "user", content: message))
        self.BASE_PARAMETERS.messages = messages
        self.chatList?["user\(self.chatIdx)"] = message
    }
    
    func incluedeStoredCard() -> [Message] {
        var messages: [Message] = []
        let cardInfos = UserDefaultsManager.shared.getAllCardsInfos()
        
        //저장된 Card들 정보랑
        for info in cardInfos {
            var message = info.companyNameNum.joined(separator: "#")
            message.append("#")
            message.append(info.companyHashTag.joined(separator: "#"))
            messages.append(Message(role: "user", content: message))
        }
        for message in BASE_PARAMETERS.messages {
            messages.append(message)
        }
        print(messages)
        return messages
    }
    
    func sendRequest(message: String, completion: @escaping (Result<String, Error>) -> Void) {
        // URL 설정 (실제 서버 엔드포인트로 변경 필요)
        guard let url = URL(string: BASE_URL + "chatGpt/prompt") else {
            print("Invalid URL")
            return
        }
        self.setMessage(message: message)
        
        let allTheMessage = self.incluedeStoredCard()
        
        // 페이로드 생성
        let payload = ChatRequestModel(
            model: self.BASE_PARAMETERS.model,
            messages: allTheMessage,
            member_id: self.BASE_PARAMETERS.member_id
        )
        
        // Alamofire를 사용한 POST 요청
        AF.request(url,
                   method: .post,
                   parameters: payload,
                   encoder: JSONParameterEncoder.default)
        .validate() // HTTP 상태 코드 200-299 검증
        .responseDecodable(of: ChatResponse.self) { response in
            switch response.result {
            case .success(let chat):
                self.chatList?["gpt\(self.chatIdx)"] = chat.content
                UserDefaultsManager.shared.saveUserChat(message: message)
                UserDefaultsManager.shared.saveGptChats(message: chat.content)
                completion(.success(chat.content))
            case .failure(let error):
                if let underlyingError = error.underlyingError {
                    completion(.failure(underlyingError))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    func sendUserchatToServer(message: String) {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: BASE_URL + "chatGpt/prompt") else {
            print("Invalid URL")
            return
        }
        self.setMessage(message: message)
        print(self.BASE_PARAMETERS.messages)
        let encoder = JSONEncoder()
        let messageData = try! encoder.encode(self.BASE_PARAMETERS.messages)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "model": self.BASE_PARAMETERS.model,
            "messages": messageData,
            "member_id": self.BASE_PARAMETERS.member_id
        ]
        //MARK: Request생성
        AF.request(sessionUrl,
                   method: .post, // HTTP메서드 설정
                   parameters: parameters, // 파라미터 설정
                   encoding: JSONEncoding.default,
                   headers: headers) // 헤더 설정
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .responseDecodable(of: [ChatResponse].self) { response in
            switch response.result {
            case .success(let chats):
                print("received Chats", chats)
                chats.forEach { chat in
                    self.chatList?["gpt\(self.chatIdx)"] = chat.content
                    UserDefaultsManager.shared.saveUserChat(message: self.chatList?["user\(self.chatIdx)"] ?? "")
                    UserDefaultsManager.shared.saveGptChats(message: chat.content)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

