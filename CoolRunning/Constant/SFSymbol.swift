
import SwiftUI

enum SFSymbol: String {
    // 主页的tabbar
    case house = "house.fill"
    case circle = "circle.circle"
    case person = "person"
    
    // MainView学期目标的小人
    case run = "figure.run"
    // LoginView的邮箱登录
    case envelope = "envelope.fill"
    // PhoneNumberLoginView的协议勾选按钮
    case checkmark = "checkmark.circle.fill"
    // RunnningView暂停后的跑步恢复按钮
    case continueRunningButton = "arrowtriangle.right.circle.fill"
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
