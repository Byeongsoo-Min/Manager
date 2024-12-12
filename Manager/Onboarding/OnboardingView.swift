//
//  OnboardingView.swift
//  Manager
//
//  Created by MBSoo on 12/12/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0
    @State private var moveToNext = false
    let images = ["onboarding1", "onboarding2", "onboarding3"]
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 24) {
                HStack {
                    Text("매니절")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("playgroundColor"))
                    Spacer()
                }.padding(.horizontal)
                    .padding(.bottom, -40)
                GeometryReader { geometry in
                    TabView(selection: $currentIndex) {
                        ForEach(0..<images.count) { index in
                            Image(images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: 300)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
                
                Text("간편한 스캔 기능")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("스마트폰으로 편하게 인식하고 \n 서비스를 이용하세요.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    self.moveToNext.toggle()
                }) {
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
                NavigationLink(destination: SecondView(), isActive: $moveToNext) {
                    Text("")
                }.navigationBarBackButtonHidden()
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingView()
}
