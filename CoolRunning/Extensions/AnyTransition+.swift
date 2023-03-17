//
//  AnyTransition+.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/6.
//

import SwiftUI

extension AnyTransition {
    static let moveTtoL: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    static let moveLtoT: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing))
    
    static let moveLtoL: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    
    static let moveTtoT: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .trailing))
}
