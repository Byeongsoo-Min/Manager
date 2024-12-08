//
//  HomeObservable.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import Foundation
import SwiftUI

class HomeObservable: ObservableObject {
    
    @Published var pageNumber: Int?
    @Published var moveToPage: Bool?
    @Published var cardsList: [Card]?
    
    var onTouchAction: (() -> Void)!
    init() {
        self.onTouchAction = self.setAction
        self.cardsList = UserDefaultsManager.shared.getAllStoredCard()
        
    }
    
    func moveToPage(id: Int) {
        var pageID = id
        //서버에서 아이디에 따라 api 요청 코드 필요
        
    }
    func resetPage(){
        self.pageNumber = nil
    }
    func setAction(){
        self.moveToPage?.toggle()
        
    }
    
}
