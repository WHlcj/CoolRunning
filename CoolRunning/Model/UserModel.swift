// 来处理账号的登录登出和信息同步
import Foundation

struct User {
    // 登录信息
    let user_phone: String
    let user_email: String
    let user_password: String
    let isLogIn: Bool // 当一名用户登录后，若再次登录则自动退出登录
    
    // 个人信息
    let user_alias: String
    let user_image: Data
    let user_motto: String
    let user_gender: String
    let user_birthday: String
    let user_weight: Int
    let user_height: Int
}
