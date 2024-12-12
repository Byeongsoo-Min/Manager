//
//  CardRegisterView.swift
//  Manager
//
//  Created by MBSoo on 12/10/24.
//

import SwiftUI

struct CardRegisterView: View {
    @State private var hashTag: String = ""
    @State private var isChatted: Bool = false
    @State private var isSubmitted: Bool = false
    @State private var moveToCamera: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView {
            if !isSubmitted {
                Spacer().frame(height: 250)
            }
            Section {
                HStack(content: {
                    Text("사진")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }).padding(.horizontal)
                Button(action: {
                    isSubmitted.toggle()
                    moveToCamera.toggle()
                    print(isSubmitted)
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.black)
                        .overlay(
                            Text("새로운 명함 인식하기")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.title2)
                                .fontWeight(.semibold)
                        )
                })
                .frame(height: 100)
                .padding()
            }
            if isSubmitted {
                Section {
                    HStack {
                        Text("주요 태그를 설정해주세요.")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(hashTag.count)/20")
                            .font(.callout)
                            .foregroundStyle(Color("playgroundColor"))
                    }.padding(.horizontal)
                    TextField(LocalizedStringKey(stringLiteral: "내용을 작성해주세요"), text: $hashTag)
                        .frame(height: 100, alignment: .topLeading)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray.opacity(0.2)))
                        .onChange(of: hashTag, perform: { value in
                            if value != "" {
                                isChatted = true
                            } else {
                                isChatted = false
                            }
                        })
                    Button {
                        UserDefaultsManager.shared.saveCompanyHashTags(messages: hashTag)
                        isSubmitted.toggle()
                        dismiss()
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
                    
                    
                }.padding()
            }
        }.fullScreenCover(isPresented: $moveToCamera, content: {
            CameraView(isPresented: $moveToCamera)
        })
        .navigationBarBackButtonHidden(isSubmitted ? true : false)
    }
}

#Preview {
    CardRegisterView()
}
