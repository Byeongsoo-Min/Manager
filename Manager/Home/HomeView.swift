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
                                NavigationLink(destination: CameraView()) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.black)
                                        .overlay(
                                            Text("새로운 명함/팜플렛 인식하기")
                                                .foregroundColor(.white.opacity(0.8))
                                        )
                                }
                                .frame(height: 56)
                                .padding()

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
                                let cardImages = UserDefaultsManager.shared.getAllCardImages()
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
            Rectangle()
                .overlay {
                    if let images = UserDefaultsManager.shared.getAllCardImages(),
                       images.indices.contains(page) {
                        CardView(observable: observable, image: images[page])
                    } else {
                        CardView(observable: observable, image: UIImage(named: "exampleCard"))
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
