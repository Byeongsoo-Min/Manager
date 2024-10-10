//
//  ExistDataView.swift
//  Manager
//
//  Created by MBSoo on 10/9/24.
//

import SwiftUI

struct ExistDataView: View {
    @ObservedObject var observable: HomeObservable
    
    var body: some View {
        Text("Hello \(observable.pageNumber ?? 10)")
    }
}

#Preview {
    ExistDataView(observable: HomeObservable())
}
