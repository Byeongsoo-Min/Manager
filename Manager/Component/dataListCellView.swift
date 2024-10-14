//
//  dataListView.swift
//  Manager
//
//  Created by MBSoo on 10/10/24.
//

import SwiftUI

struct dataListCellView: View {
    var isCard = true
    var companyName = "경희대학교" //더미데이터 수정 필요
    var hashtagArray = ["경기도", "용인", "컴퓨터공학과"] //더미데이터 수정 필요
    var addedDate = Date()
    var body: some View {
        VStack {
            HStack {
                if isCard {
                    Text("명함")
                        .encapulate(color: Color("playgroundColor"), foregroundColor: .white)
                        .onTapGesture {
                            print("2312321")
                        }
                } else {
                    Text("팜플렛")
                        .encapulate(borderColor: Color("playgroundColor"))
                        .foregroundColor(Color("playgroundColor"))
                }
                Spacer()
                Text("\(addedDate.formatted())") // 추가된 날짜 백엔드에서 받아와서 오늘 날짜랑 계산해서 표기하기 (하루전 2일전..)
            }.padding()
            HStack {
                Text(companyName)
                Spacer()
            } .padding(.horizontal)
            HStack {
                ForEach(hashtagArray, id: \.self){ data in
                    Text("#\(data)")
                }
                Spacer()
            }.padding(.horizontal)
        }.padding()
    }
    func calcDate(addedDate: Date){ // 백엔드에서 받아오는 날짜로 대신
        var howFarDate = 0
        print(Date().hashValue)
        print(1234)
    }
}

#Preview {
    dataListCellView()
}
