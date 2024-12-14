//
//  CheckDataView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct CheckDataView: View {
    @State private var toggleCard: Bool = false
    @State private var togglePamplete: Bool = false
    @State private var isShowing: Bool = false
    
    @State var sort = sortedTool.newest
    @StateObject var networking = CheckDataViewModel()
    
    @State var cardImage = Image("exampleCard")
    @State var cardInfos: [String] = ["",""]
    @State var hashTags: [String] = []
    
    var body: some View {
        VStack {
            HStack{
                Text("매니절")
                    .customFont(size: 40)
                    .fontWeight(.bold)
                    .foregroundColor(Color("playgroundColor"))
                Spacer()
            }.padding(.horizontal)
            HStack(spacing: 16) {
                Text("전체")
                    .fontWeight(.bold)
                    .onTapGesture {
                        toggleCard = false
                        togglePamplete = false
                    }
                    .foregroundColor(!toggleCard && !togglePamplete ? .black : .gray) // 둘다 false일때
                Text("명함")
                    .fontWeight(.bold)
                    .onTapGesture {
                        toggleCard.toggle()
                        togglePamplete = false
                    }
                    .foregroundColor(toggleCard ? .black : .gray)
                Text("팜플렛")
                    .fontWeight(.bold)
                    .onTapGesture {
                        togglePamplete.toggle()
                        toggleCard = false
                    }
                    .foregroundColor(togglePamplete ? .black : .gray)
                Spacer()
            }.font(.title)
            .padding()
            HStack {
                Spacer()
                Picker(sort.rawValue, selection: $sort) {
                    ForEach(sortedTool.allCases, id: \.self) { value in
                        Text(value.rawValue)
                            .tag(value)
                    }
                }.colorMultiply(.black)
                    .pickerStyle(.menu)
            }.padding(.horizontal)
            Divider().padding(.top)
            ScrollView {
                VStack {
                    ForEach(networking.cachedList ?? [], id: \.companyNameNum) { info in
                        dataListCellView(info: info)
                            .onTapGesture {
                                self.cardImage = Image(uiImage: info.image)
                                self.cardInfos = info.companyNameNum
                                self.hashTags = info.companyHashTag
                                print(self.cardInfos)
                                self.isShowing = true
                            }
                        Divider().frame(height: 10)
                    }
                   
                    if let _ = networking.cardList {
                        

                    } else {
                        Text("카드를 등록해주세요!")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("playgroundColor"))
                            .padding()
                    }
                }
            }
            Spacer()
            
        }
        .fullScreenCover(isPresented: $isShowing, content: {
            ConfirmDataView(cardImage: self.$cardImage, cardInfos: self.$cardInfos, hashTags: self.$hashTags, isPresented: $isShowing)
        })
        .onAppear(perform: {
            networking.alamofireNetworking()
            networking.refreshCards()
            print(networking.cachedList)
        })
    }
}

#Preview {
    CheckDataView()
}
