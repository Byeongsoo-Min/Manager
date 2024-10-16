//
//  HomeView.swift
//  Manager
//
//  Created by MBSoo on 10/7/24.
//

import SwiftUI
import SwiftUIPager

struct HomeView: View {
    @StateObject var page1: Page = .first()
    @StateObject var page2: Page = .first()
    @ObservedObject var observable: HomeObservable = HomeObservable()
    @State var isShowing: Bool = false
    
    private var data = Array(0..<6)
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer().background(.red)
                    Rectangle()
                        .frame(height: 280)
                        .foregroundColor(Color("playgroundColor"))
                        .overlay(
                            VStack{
                                Spacer()
                                Rectangle()
                                    .frame(height: 5)
                                    .foregroundColor(.white)
                                Spacer()
                                Rectangle()
                                    .frame(height: 5)
                                    .foregroundColor(.white)
                                Spacer()
                                Rectangle()
                                    .frame(height: 5)
                                    .foregroundColor(.white)
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                        )
                }
                    GeometryReader { proxy in
                        VStack(spacing: 31) {
                            HStack{
                                Text("매니절")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Spacer()
                            }.padding(.horizontal)
                            Pager(page: self.page2,
                                  data: self.data,
                                  id: \.self) { pageNumber in
                                self.pageView(pageNumber)
                                    .onTapGesture {
                                        observable.pageNumber = pageNumber
                                        observable.onTouchAction()
                                        isShowing = observable.moveToPage ?? true
                                    }
                            }
                                  .itemSpacing(10)
                                  .loopPages(true)
                                  .horizontal(.startToEnd)
                                  .interactive(scale: 0.8)
                                  .itemAspectRatio(0.7)
                                  .background(.white)
                                  .frame(height: 400)
                            
                            Pager(page: self.page2,
                                  data: self.data,
                                  id: \.self) {
                                self.pageView2($0)
                            }.itemSpacing(100)
                                .loopPages(true)
                                .horizontal(.startToEnd)
                                .interactive(scale: 0.6)
                                .itemAspectRatio(0.4)
                                .frame(height: 120)
                        }
                    }
                    NavigationLink(destination: ExistDataView(observable: observable), isActive: $isShowing) {
                        Text("")
                    }.padding()
                    
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func pageView(_ page: Int) -> some View {
        ZStack {
            if page == 0 {
                Rectangle()
                    .overlay {
                        CardView(observable: observable, page: page)
                    }
            }
            
            if page == 1 {
                Rectangle()
                    .overlay {
                        CardView(observable: observable, page: page)
                    }
            }
            
            if page == 2 {
                Rectangle()
                    .overlay {
                        CardView(observable: observable, page: page)
                    }
            }
            
            if page == 3 {
                Rectangle()
                    .overlay {
                        CardView(observable: observable, page: page)
                    }
            }
            
            if page == 4 {
                Rectangle()
                    .overlay {
                        CardView(observable: observable, page: page)
                    }
            }
            
            if page == 5 {
                Rectangle()
                    .overlay {
                        CardView(observable: observable, page: page)
                    }
            }
        }
        .cornerRadius(16)
    }
    func pageView2(_ page: Int) -> some View {
        ZStack {
            
            if page == 0 {
                Image("runningManager1")
                    .resizable()
                    .frame(width: 85, height: 109)
            }
            
            if page == 1 {
                Image("runningManager2")
                    .resizable()
                    .frame(width: 85, height: 109)
            }
            
            if page == 2 {
                Image("runningManager3")
                    .resizable()
                    .frame(width: 85, height: 109)
            }
            
            if page == 3 {
                Image("runningManager1")
                    .resizable()
                    .frame(width: 85, height: 109)
            }
            
            if page == 4 {
                Image("runningManager2")
                    .resizable()
                    .frame(width: 85, height: 109)
            }
            
            if page == 5 {
                Image("runningManager3")
                    .resizable()
                    .frame(width: 85, height: 109)
            }
        }
    }
}




#Preview {
    HomeView()
}
