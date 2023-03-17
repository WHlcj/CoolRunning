//
//  ShapeStyle+.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/15.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    
    func bg() -> some View {
        RadialGradient(
            gradient: Gradient(colors: [.purple, .cyan]),
            center: .topLeading,
            startRadius: 10,
            endRadius: UIScreen.main.bounds.height)
    }
}
