//
//  extensions.swift
//  Manager
//
//  Created by MBSoo on 10/10/24.
//

import Foundation
import SwiftUI

extension View {
    func encapulate(color: Color, foregroundColor: Color = .black) -> some View {
        return self
            .padding(7)
            .padding(.horizontal, 5)
            .background(Capsule().fill(color))
            .foregroundColor(foregroundColor)
    }
    
    func encapulate(borderColor: Color) -> some View {
        return self
            .padding(7)
            .padding(.horizontal, 5)
            .overlay(Capsule().stroke(borderColor))
    }
    func customFont(size: CGFloat) -> some View {
            self.modifier(CustomFontModifier(size: size))
        }
}


struct CustomFontModifier: ViewModifier {
    let fontName: String = "CWDangamAsac-Bold"
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: size)) // 지정한 커스텀 폰트 사용
    }
}
