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
    let pageIdx: Int
    var body: some View {
        Rectangle()
            .overlay {
                ZStack{
                    if let uiImage = decodeBase64ToImage(base64String: observable.cardsList?[pageIdx].imageBase64){
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
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
                            Text("\(observable.cardsList?[pageIdx].companyName ?? "경희대학교")") // 명함 회사
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        HStack(spacing: 0){
                            Text("\(observable.cardsList?[pageIdx].companyNumber ?? "010-1111-1111")") // 명함 전화번호
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
     func decodeBase64ToImage(base64String: String?) -> UIImage? {
         guard let imageData = Data(base64Encoded: base64String!, options: .ignoreUnknownCharacters) else {
             return nil
         }
         return UIImage(data: imageData)
     }
}

//#Preview {
//    CardView(observable: HomeObservable(), page: 0)
//}
