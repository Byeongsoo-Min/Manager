//
//  ConfirmDataView.swift
//  Manager
//
//  Created by MBSoo on 12/12/24.
//

import SwiftUI

struct ConfirmDataView: View {
    @Binding var cardImage: Image
    @Binding var cardInfos: [String]
    @Binding var hashTags: [String]
    @Binding var isPresented: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }, label: {
                    Image(systemName: "xmark.app")
                        .resizable()
                        .frame(width:30,height: 30)
                        .foregroundColor(Color("playgroundColor"))
                        
                })
            }
            HStack {
                Spacer()
                cardImage
                    .resizable()
                    .frame(width: 200)
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Divider().frame(height: 10)
            if true {
                Text("명함")
                    .encapulate(color: Color("playgroundColor"), foregroundColor: .white)
            } else {
                Text("팜플렛")
                    .encapulate(borderColor: Color("playgroundColor"))
                    .foregroundColor(Color("playgroundColor"))
            }
            HStack(spacing: 10, content: {
                ForEach(hashTags, id: \.self) { message in
                    Text("#\(message)")
                }
            })
            Divider().frame(height: 10)
            Text("정보 확인")
                .font(.title2)
                .fontWeight(.semibold)
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("이름: \(self.cardInfos[0])")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding(.horizontal)
                    HStack {
                        Text("전화번호: \(self.cardInfos[1])")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray.opacity(0.2))
            )
            .padding()
            
        }
        .onAppear(perform: {
            cardInfos.append("")
        })
        .padding()
    }
}

//#Preview {
//    ConfirmDataView()
//}
