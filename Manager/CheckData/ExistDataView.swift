//
//  ExistDataView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct ExistDataView: View {
    @ObservedObject var observable: HomeObservable
    @State var cardImage = Image("exampleCard")
    @State var cardInfos: [String] = ["",""]
    @State var hashTags: [String] = []
    //MARK: pageNumber랑 저장된 컴패니의 갯수를 맞추는 방법을 찾아야함.
    //MARK: 방법1: 키랑 이미지 같이 뱉는 펑션 만들고, substring으로 index 추출해서 hashtag 불러오기
    //MARK: 방법2: remote 서버 테이블 다 드랍시키고 다시 만들기 
    var body: some View {
        VStack(alignment: .leading) {
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
        .padding()
        .onAppear(perform: {
            print(observable.pageNumber)
            let card = UserDefaultsManager.shared.getCompanyInfos(pageIdx: observable.pageNumber ?? 0)
            
            cardImage = Image(uiImage: card.image)
            cardInfos = card.companyNameNum
            hashTags = card.companyHashTag
            print(cardInfos)
        })
    }
}

//#Preview {
//    ExistDataView(observable: HomeObservable())
//}
