// 来处理账号的登录登出和信息同步
import Foundation

struct UserModel {
    
}

struct User {
    // 用户手机号
    let user_phone: String
    // 用户邮箱
    let user_email: String?
    // 用户密码
    let user_password: String
    //let isLogIn: Bool // 当一名用户登录后，若再次登录则自动退出登录
    // 用户昵称
    let user_alias: String
    // 用户头像
    let user_image: Data
    // 用户个性签名
    let user_motto: String
    // 用户性别
    let user_gender: String
    // 用户生日
    let user_birthday: String
    // 用户体重
    let user_weight: Int = 60
    // 用户身高
    let user_height: Int = 120
}
