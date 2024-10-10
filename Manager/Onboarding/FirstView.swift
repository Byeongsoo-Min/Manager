//
//  ContentView.swift
//  Manager
//
//  Created by MBSoo on 10/7/24.
//

import SwiftUI

struct FirstView: View {
    @State private var moveToNext:Bool = false
    var body: some View {
        NavigationStack{
            VStack {
                Text("종이를 디지털로, 혁신의 시작")
                    .font(.title)
                    .padding(.bottom, 24)
                Text("잃어버리기 쉬운 명함과 팜플렛들을\n디지털 데이터로 저장해 관리하세요.")
                    .font(.title3)
                    .padding(.bottom, 50)
                HStack(spacing: 30){
                    Image(systemName: "newspaper.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Image(systemName: "plus.rectangle.on.folder.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        
                }.padding()
                
                Spacer()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                Button {
                    moveToNext = true
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.black)
                        .frame(height: 56)
                        .padding(.horizontal, 20)
                        .overlay(
                            Text("시작하기")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                }
                .padding(.bottom, 24)
                NavigationLink(destination: SecondView(), isActive: $moveToNext) {
                    Text("")
                }.navigationBarBackButtonHidden()
                
            }
            .padding()
        }
    }
}

#Preview {
    FirstView()
}
