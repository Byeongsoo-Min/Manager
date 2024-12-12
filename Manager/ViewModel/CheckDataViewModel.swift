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
    var image: String
    var cardId: Int
}

class CheckDataViewModel: ObservableObject {
    @Published var cardList: [Card]?
    @Published var cachedList: [UserDefaultsManager.CompanyInfo]?
    @Published var nameSort = SortBy.nameASC
    @Published var ratingSort = SortBy.ratingASC
    var BASE_URL = APIClient.BASE_URL
    
    func refreshCards() {
        cachedList = UserDefaultsManager.shared.getAllCardsInfos()
    }
    
    func updateList(tempList: [Card]) {
        self.cardList = tempList
    }
    
    func alamofireNetworking() {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: BASE_URL + "card/retrieve") else {
            print("Invalid URL")
            return
        }
        let parameters: Parameters = [
            "memberId" : UserDefaultsManager.shared.getMemeberId()
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
                var tempList: [Card] = []
                cards.forEach { card in
                    tempList.append(card)
                    print(card.companyName)
                    self.updateList(tempList: tempList)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // For convinience. Sort type.
    enum SortBy: String {
        case nameASC = "Name △"
        case nameDESC = "Name ▽"
        case ratingASC = "Date △"
        case ratingDESC = "Date ▽"
    }
}
