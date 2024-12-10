//
//  ExistDataView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct ExistDataView: View {
    @ObservedObject var observable: HomeObservable
    //MARK: pageNumber랑 저장된 컴패니의 갯수를 맞추는 방법을 찾아야함.
    //MARK: 방법1: 키랑 이미지 같이 뱉는 펑션 만들고, substring으로 index 추출해서 hashtag 불러오기
    //MARK: 방법2: remote 서버 테이블 다 드랍시키고 다시 만들기 
    var body: some View {
        Text("Hello \(observable.pageNumber ?? 10)")
    }
}

#Preview {
    ExistDataView(observable: HomeObservable())
}
