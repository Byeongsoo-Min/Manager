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
    var body: some View {
        VStack {
            HStack {
                Text("매니절")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Spacer()
            }.padding()
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
            }.padding()
            ScrollView {
                VStack {
                    
                }
            }
            Spacer()
            
        }
    }
}

#Preview {
    CheckDataView()
}
