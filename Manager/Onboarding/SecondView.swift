//
//  SecondView.swift
//  Manager
//
//  Created by MBSoo on 10/7/24.
//

import SwiftUI

struct SecondView: View {
    @State var name:String = ""
    @State var moveToNext:Bool = false
    var body: some View {
        VStack {
            Text("매니절을 고용하세요.")
                .font(.title)
                .padding(.bottom, 24)
            Text("OCR로 손쉽게 정보를 입력하세요.\n정보는 당신의 매니절이 기억할게요.")
                .font(.title3)
                .padding(.bottom, 50)
            Image(systemName: "person.bubble.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, 50)
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                     .stroke(.black,lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                     .padding(.horizontal, 24)
                     .frame(height: 56)
                     .foregroundColor(.white)
                TextField("입력해주세요", text: $name)
                    .padding(.horizontal, 50)
            }
            if(name != "") {
                Button {
                    moveToNext = true
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.black)
                        .frame(height: 56)
                        .padding(.horizontal, 20)
                        .overlay(
                            Text("고용하기")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                }
                .padding(.bottom, 24)
            }
            NavigationLink(
                destination: TabBarView(),
                isActive: $moveToNext,
                label: {
                    Text("")
                })
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SecondView()
}
