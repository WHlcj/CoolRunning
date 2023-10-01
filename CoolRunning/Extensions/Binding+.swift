
import SwiftUI

extension Binding where Value == String {
    
    /// 验证码输入处限制输入的数量
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
