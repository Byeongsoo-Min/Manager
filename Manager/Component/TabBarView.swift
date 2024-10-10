//
//  TabBar.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: Int = 0
    var body: some View {
        TabView(selection: $selection,
                content:  {
            HomeView().tabItem {
                VStack{
                    Image(systemName: "person.text.rectangle.fill")
                    Text("메인")
                } }.tag(0)
            CheckDataView().tabItem {
                VStack{
                    Image(systemName: "book.fill")
                    Text("데이터 보기")
                } }.tag(1)
            ConversationView().tabItem {
                VStack{
                    Image(systemName: "person.2.fill")
                    Text("대화하기")
                } }.tag(2)
        })
        .fontWeight(.bold)
        .accentColor(.pink)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
}
