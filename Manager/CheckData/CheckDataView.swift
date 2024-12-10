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
    
    @State var sort = sortedTool.newest
    @StateObject var networking = CheckDataViewModel()
    private var dummyData = ["경희대학교", "한국항공산업", "카카오 엔터테인먼트", "한화 에어로 스페이스"]
    var body: some View {
        VStack {
            HStack{
                Text("매니절")
                    .font(.largeTitle)
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
                    ForEach(networking.cardList ?? [], id: \.cardId) { card in
                        dataListCellView(card: card)
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
            
        }.onAppear(perform: {
            networking.alamofireNetworking()
        })
    }
}

#Preview {
    CheckDataView()
}
