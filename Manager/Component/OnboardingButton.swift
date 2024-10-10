//
//  OnboardingButton.swift
//  Manager
//
//  Created by MBSoo on 10/7/24.
//

import SwiftUI

struct OnboardingButton: View {
    var body: some View {
        HStack{
            Text("다음")
                .fontWeight(.bold)
                .foregroundColor(.white)
        }.background(.black)
    }
}

#Preview {
    OnboardingButton()
}
