//
//  SFSymbol.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/2/27.
//

import SwiftUI

enum SFSymbol: String {
    case house = "house.fill"
    case person = "person"
    case run = "figure.run"
    case circle = "circle.circle"
    case envelope = "envelope.fill"
    case rarrow = "chevron.right"
}

extension SFSymbol: View {
    var body: Image {
        Image(systemName: rawValue)
    }
    
    func resizeable() -> Image {
        self.body.resizable()
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ text: String, systemImage: SFSymbol) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}
