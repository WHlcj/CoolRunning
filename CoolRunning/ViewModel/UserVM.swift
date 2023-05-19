
// TO DO:
/*
  1. 实现本地mysql的增删改查
 */

import Foundation
import OHMySQL

class UserVM {
    
    @Published var user: User
    
    private let mysqlUser = MySQLConfiguration(
        user: "root",
        password: "a1234567890s",
        serverName: "localhost",
        dbName: "CoolRunning",
        port: 3306,
        socket: nil)
    
    init(user: User) {
        self.user = user
    }
    


    
}

// MARK: - 本地mysql配置
extension UserVM {
   
    func initMysql() {
        let coordinator = MySQLStoreCoordinator(configuration: mysqlUser)
        coordinator.encoding = .UTF8MB4
        coordinator.connect()
        
        guard coordinator.isConnected else {
            print("数据库连接失败！")
            return }
        // 要执行查询，您必须创建上下文：
        let context = MySQLQueryContext()
        context.storeCoordinator = coordinator
        
        let query = MySQLQueryRequestFactory.insert("tb_account", set: ["user_name" : "whlcj", "user_password" : "123123", "user_phone" : "11111111"])
        do {
            let response = try context.executeQueryRequestAndFetchResult(query)
            print("response:\(response as Any)")
            
        }catch {
            print("MySQL_Error:\(error)")
        }
        
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
