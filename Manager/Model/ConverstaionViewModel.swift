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
    
    var BASE_URL = APIClient.BASE_URL
    var BASE_PARAMETERS = ChatRequestModel(model: "gpt-3.5-turbo", messages: [], member_id: UserDefaultsManager.shared.getMemeberId())
    
    func setMessage(message: String) {
        var messages: [Message] = []
        messages.append(Message(role: "system", content: "Store each business card that is provided along with its tags. For every subsequent query:- Analyze the query for relevant keywords or details. - Retrieve the most appropriate business card based on the matches between the query and stored information. - If there are multiple suitable cards, return the one that most closely matches. The user's response is divided into /. Answer in korean."))
        messages.append(Message(role: "user", content: message))
        self.BASE_PARAMETERS.messages = messages
    }
    
    func sendUserchatToServer(message: String) {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: BASE_URL + "chatGpt/prompt") else {
            print("Invalid URL")
            return
        }
        self.setMessage(message: message)
        let parameters: Parameters = [
            "model": self.BASE_PARAMETERS.model,
            "message": self.BASE_PARAMETERS.messages,
            "memberId" : self.BASE_PARAMETERS.member_id
            
        ]
        let headers: HTTPHeaders = [
            HTTPHeader.contentType("application/json")
        ]
        //MARK: Request생성
        AF.request(sessionUrl,
                   method: .post, // HTTP메서드 설정
                   parameters: parameters, // 파라미터 설정
                   encoding: URLEncoding.default,
                   headers: headers) // 헤더 설정
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .responseDecodable(of: [ChatResponse].self) { response in
            switch response.result {
            case .success(let chats):
                print("received Chats", chats)
                chats.forEach { chat in
                    self.contentList?.append(chat)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
