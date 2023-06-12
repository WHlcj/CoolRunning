
import SwiftUI

struct draft1: View {

    var body: some View {
        VStack {
            Button("click it") {
                //initMysql()
            }
        }
    }
    
}

extension draft1 {
//    func initMysql() {
//        let user = MySQLConfiguration(
//            user: "root",
//            password: "a1234567890s",
//            serverName: "localhost",
//            dbName: "CoolRunning",
//            port: 3306,
//            socket: nil) //
//
//        let coordinator = MySQLStoreCoordinator(configuration: user)
//        coordinator.encoding = .UTF8MB4
//        coordinator.connect()
//
//        guard coordinator.isConnected else {
//            print("数据库连接失败！")
//            return }
//        // 要执行查询，您必须创建上下文：
//        let context = MySQLQueryContext()
//        context.storeCoordinator = coordinator
//        // 添加数据
//        let query = MySQLQueryRequestFactory.insert("tb_account", set: ["user_name" : "whlcj", "user_password" : "123123", "user_phone" : "11111111"])
//        do {
//            let response = try context.executeQueryRequestAndFetchResult(query)
//            print("response:\(response as Any)")
//
//         }catch {
//             print("MySQL_Error:\(error)")
//        }
//
//    }
}

struct draft1_Previews: PreviewProvider {
    static var previews: some View {
        draft1()
    }
}
