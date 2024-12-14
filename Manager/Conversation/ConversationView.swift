//
//  ConversationView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct ConversationView: View {
    //MARK: 딕셔너리 사용하되, index를 집어넣어 key값을 바꾸도록 한 방법대로 진행. foreach 어떻게 돌리지 그럼? 아래 로직 처럼 user\(idx) -> 1, 11, 111 로 변경 하고 돌리기 해야하나?? 생각 해봐야할듯
    var managerName = "매니절"
    let date = Date()
    let dateFormatter = DateFormatter()
    @State var chatList = [1 : "오늘도 좋은 하루에요! 현재 시간은 "] // 1 , 11,  111, 2, 22, 222
    @State private var ownerChat: String = ""
    @State private var isChatted: Bool = false
    
    @State private var userIdx = 2
    @State private var gptIdx = 11
    @StateObject var ConvViewModel = ConverstaionViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(chatList.sorted(by: <), id: \.key) { key, _ in
                    if key % 2 == 1 { // chatGPT
                        Text(managerName)
                            .customFont(size: 20)
                            .foregroundStyle(Color("playgroundColor"))
                        Text(chatList[key] ?? "")
                            .foregroundStyle(.black)
                    } else { // owner
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.indigo.opacity(0.2))
                            .overlay {
                                VStack(alignment: .leading) {
                                    Text(chatList[key] ?? "")
                                        .foregroundStyle(.black)
                                }
                            }
                            .frame(minHeight: 150)
                    }
                    Divider()
                }
                
                Section {
                    TextField(LocalizedStringKey(stringLiteral: "내용을 작성해주세요"), text: $ownerChat)
                        .frame(height: 250, alignment: .topLeading)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray.opacity(0.2)))
                        .onChange(of: ownerChat, perform: { value in
                            if value != "" {
                                isChatted = true
                            } else {
                                isChatted = false
                            }
                        })
                    Button {
                        Task {
                            await pushToChatGPTAPI(chat: ownerChat)
                            self.ownerChat = ""
                        }
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .overlay(content: {
                                Text("작성완료")
                                    .foregroundStyle(isChatted ? .black : .black.opacity(0.4))
                            })
                            .foregroundColor(Color("playgroundColor"))
                            .padding()
                    }
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                
            }
            .padding(24)
        }
        .onAppear(perform: {
            self.chatList[1] = "오늘도 좋은 하루에요! 현재 시간은 \(calcDate(addedDate: date)) 이에요!"
            let chats = ConvViewModel.chatList ?? [:]
            print(chats)
            for key in chats.keys.sorted() {
                if let chat = chats[key] {
                    if key[key.startIndex] == "u" {
                        self.chatList[self.userIdx] = chat
                        self.userIdx = self.userIdx * 10 + 2
                    } else {
                        self.chatList[self.gptIdx] = chat
                        self.gptIdx = self.gptIdx * 10 + 1
                    }
                }
            }
        })
    }
    func pushToChatGPTAPI(chat: String) async -> Void {
        self.userIdx *= 10 + 2
        self.chatList[userIdx] = chat
        self.ConvViewModel.sendRequest(message: chat, completion: { result in
            switch result {
            case .success(let content):
                self.gptIdx *= 10 + 1
                self.chatList[self.gptIdx] = content
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
            
        })
        print("do something")
    }
    func calcDate(addedDate: Date) -> String{ // 백엔드에서 받아오는 날짜로 대신
        dateFormatter.dateFormat = "hh시 mm분"
        let formattedDate = dateFormatter.string(from: addedDate)
        
        return formattedDate
    }
}

#Preview {
    ConversationView()
}
