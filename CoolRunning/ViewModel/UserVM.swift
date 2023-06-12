
// TO DO:
/*
  1. 实现本地mysql的增删改查
 */

import Foundation

class UserVM {
    
    @Published var user: User

    
    init(user: User) {
        self.user = user
    }
    
    
}

// MARK: - 本地mysql配置
extension UserVM {
   
    func initUser() {
    }
    
    // 添加用户
    func addAccount() {

    }
    // 更新账号
    func updateAccount() {
        
    }
    // 注销账号
    func deleteAccount() {
        
    }
    // 查询账号
    func selectAccount() {
        
    }
}
