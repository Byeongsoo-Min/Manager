//
//  CheckDataViewModel.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation
import Alamofire
import UIKit

struct Card: Codable {
    var companyName: String
    var companyNumber: String
    var imageBase64: String
    var cardId: Int
}

class CheckDataViewModel: ObservableObject {
    @Published var cardList: [Card]?
    @Published var nameSort = SortBy.nameASC
    @Published var ratingSort = SortBy.ratingASC
    var BASE_URL = APIClient.BASE_URL
    
    func alamofireNetworking() {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: BASE_URL + "card/retrieve") else {
            print("Invalid URL")
            return
        }
        let parameters: Parameters = [
            "memberId" : 11
        ]
        //MARK: Request생성
        AF.request(sessionUrl,
                   method: .get, // HTTP메서드 설정
                   parameters: parameters, // 파라미터 설정
                   encoding: URLEncoding.default) // 헤더 설정
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .responseDecodable(of: [Card].self) { response in
            switch response.result {
            case .success(let cards):
                print("received Cards", cards)
                cards.forEach { card in
                    self.cardList?.append(card)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func alamofireFixtureDetail<T: Decodable>(url: String, itemId: Int) async throws -> T{
        let sessionUrl = URL(string: url.appending("/\(itemId)"))
        print("get fixture detail", sessionUrl)
        //MARK: Request생성
        
        return try await AF.request(sessionUrl!,
                   method: .get, // HTTP메서드 설정
                   parameters: nil, // 파라미터 설정
                   encoding: URLEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json"]) // 헤더 설정
//        .validate(statusCode: 200..<300) // 유효성 검사
//        MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .serializingDecodable()
        .value
//        .responseDecodable(of: FixtureDetail.self) { response in
//            switch response.result {
//            case .success(let book):
//                print(">>>>>>>>", book)
//                self.fixture = book.data
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
//        return try await fixture ?? Book(name: "오류 발생")
    }
    
    // For convinience. Sort type.
    enum SortBy: String {
        case nameASC = "Name △"
        case nameDESC = "Name ▽"
        case ratingASC = "Date △"
        case ratingDESC = "Date ▽"
    }
}
