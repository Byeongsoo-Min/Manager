//
//  DummyCardView.swift
//  Manager
//
//  Created by MBSoo on 12/5/24.
//

import SwiftUI

struct DummyCardView: View {
    @State var isShowing: Bool = false
    var body: some View {
        Rectangle()
            .overlay {
                ZStack{
                    Image("exampleCard")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                VStack(spacing: 0){
                    HStack(spacing: 0){
                        Spacer()
                        Button{
                            isShowing.toggle()
                        } label: {
                            Image(systemName: "photo.artframe")
                                .foregroundColor(.white)
                                .font(.system(size: 32))
                        }
                    }
                    .padding(.top, 25)
                    
                    Spacer()
                    
                    HStack(spacing: 0){
                        Text("경희대학교") // 명함 회사
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    HStack(spacing: 0){
                        Text("010-1111-1111") // 명함 전화번호
                            .font(.system(size: 17))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 25)
                    
                }.padding(.horizontal, 20)
            }
            .foregroundColor(Color("cardBackgroundColor"))
    }
        
}

#Preview {
    DummyCardView()
}
