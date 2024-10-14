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
}
