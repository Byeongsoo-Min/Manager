//
//  ConversationView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct ConversationView: View {
    var managerName = "매니절"
    @State var dummyChat1 = [1 : "오늘도 좋은 하루에요! 저번에 저장한 KAI에 대해 알아보는건 어때요?",] // contain(1) ==> chatGPT, contain(2) ==> owner
    @State private var newDummyChat = [:]
    @State private var ownerChat: String = ""
    @State private var isChatted: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(dummyChat1.sorted(by: <), id: \.key) { dummyKeys, _ in
                    if dummyKeys % 2 == 1 { // chatGPT
                        Text(managerName)
                            .foregroundStyle(Color("playgroundColor"))
                        Text(dummyChat1[dummyKeys] ?? "")
                            .foregroundStyle(.black)
                    } else { // owner
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.gray.opacity(0.2))
                            .overlay {
                                Text(dummyChat1[dummyKeys] ?? "")
                                    .foregroundStyle(.black)
                            }
                            .frame(minHeight: 200)
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
    }
    func pushToChatGPTAPI(chat: String) async -> Void { // dummy
        dummyChat1[2] = chat
        print("do something")
    }
}

#Preview {
    ConversationView()
}
