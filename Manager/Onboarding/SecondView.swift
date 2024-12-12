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
    @ObservedObject var uservm = UserViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                Text("매니절")
                    .customFont(size: 40)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("playgroundColor"))
                Spacer()
            }.padding(.horizontal)
                .padding(.bottom)
            HStack {
                Text("완벽한 사회생활을 위한 개인 비서")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }.padding(.horizontal)
            Image("manager")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)
                .padding(.bottom)
            Text("매니절을 고용하세요.")
                .font(.title)
                .fontWeight(.semibold)
            Text("OCR로 손쉽게 정보를 입력하세요.\n정보는 당신의 매니절이 기억할게요.")
                .font(.title3)
                .padding(.bottom, 50)
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                     .stroke(.black,lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                     .padding(.horizontal, 24)
                     .frame(height: 56)
                     .foregroundColor(.white)
                TextField("입력해주세요 (3글자 이상)", text: $name)
                    .padding(.horizontal, 50)
            }
            if(name.count > 2) {
                Button {
                    moveToNext = true
                    uservm.signUp(manager_name: self.name)
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
        .onAppear(perform: {
            for family in UIFont.familyNames {
                print("Font family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print("Font name: \(name)")
                }
            }
        })
    }
}

#Preview {
    SecondView()
}
