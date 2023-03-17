//
//  Binding+.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/8.
//

import SwiftUI

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
