//
//  dataListView.swift
//  Manager
//
//  Created by MBSoo on 10/10/24.
//

import SwiftUI

struct dataListCellView: View {
    var isCard = true
    var addedDate = Date()
    let dateFormatter = DateFormatter()
    let info: UserDefaultsManager.CompanyInfo
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
                Text("\(calcDate(addedDate:addedDate))") // 추가된 날짜 백엔드에서 받아와서 오늘 날짜랑 계산해서 표기하기 (하루전 2일전..)
            }.padding()
            HStack {
                Text(info.companyNameNum[0])
                Spacer()
            } .padding(.horizontal)
            HStack {
                ForEach(info.companyHashTag, id: \.self){ data in
                    Text("#\(data)")
                }
                Spacer()
            }.padding(.horizontal)
        }.padding()
    }
    func calcDate(addedDate: Date) -> String{ // 백엔드에서 받아오는 날짜로 대신
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = dateFormatter.string(from: addedDate)
        
        return formattedDate
    }
}

//#Preview {
//    dataListCellView()
//}
