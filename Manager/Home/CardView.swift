//
//  CardView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct CardView: View { //명함일때
    @State var isShowing: Bool = false
    @ObservedObject var observable: HomeObservable
    let image: UIImage?
    
    var body: some View {
        Rectangle()
            .overlay {
                ZStack{
                    Image(uiImage: ((image ?? UIImage(named: "exampleCard"))! ))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
                            Text("카카오 엔터테인먼트") // 명함 회사
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
            }
            .foregroundColor(Color("cardBackgroundColor"))
    }
}

//#Preview {
//    CardView(observable: HomeObservable(), page: 0)
//}
