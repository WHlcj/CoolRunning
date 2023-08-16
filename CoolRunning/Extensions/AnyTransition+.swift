
import SwiftUI

// View跳转的动画
extension AnyTransition {
    // 右进左出
    static let moveTtoL: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    // 左进右出
    static let moveLtoT: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing))
    // 左进左出
    static let moveLtoL: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    // 右进右出
    static let moveTtoT: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .trailing))
}
