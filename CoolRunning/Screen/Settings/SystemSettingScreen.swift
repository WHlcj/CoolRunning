//
//  SystemSettingScreen.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/6.
//

// TO DO
/*
 1. 搞懂.alert的用法,美化.alert
 */


import SwiftUI

struct SystemSettingScreen: View {
    // MARK: MainBody
    @Environment(\.dismiss) var dismiss
    @AppStorage("signed_in") var currentUserSignedIn = false
    // 用户信息
    @AppStorage("user_image") var userImage: String = "me"
    @AppStorage("user_name") var userName: String = "Elee"
    @AppStorage("user_motto") var userMotto: String = "IOS底层分子"
    
    // 控制管理
    @State private var cacheSize: String = ""
    @State private var showCleanSheet: Bool = false
    @State private var isCleaning = false
    @State private var showAlert: Bool = false

    var body: some View {
        ZStack {
            VStack {
                Form {
                    NavigationLink(destination: PersonalDetailView(), label: {
                        mineMessageView
                    })
                    functionArea
                    logOutButton
                }
            }
            .alert("", isPresented: $showAlert, actions: {
                logOut
            }, message: {
                Text("你确定要退出登录吗？")
            })
            sheets
        }
        .navigationTitle("设置")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Components
extension SystemSettingScreen {
    
    // Sheet管理
    private var sheets: some View {
        ZStack {
            if showCleanSheet {
                CleanSuccessView()
                    .onAppear {
                        isCleaning = true
                    }
                    .onDisappear {
                        isCleaning = false
                    }
            }
        }
        .zIndex(2)
    }
    // 个人信息
    private var mineMessageView: some View {
        Section {
            Button(action: {
                
            }) {
                HStack(spacing: 15) {
                    Image(userImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 1))

                    VStack(alignment: .leading, spacing: 7) {
                        Text(userName)
                            .font(.title3.bold())
                            .foregroundColor(.black)
                        Text(userMotto)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
   
                }
                .padding(.vertical, 5)
            }
        }
    }
    // 功能栏
    private var functionArea: some View {
        Section {
            NavigationLink(destination: AccountBindingView(), label: {
                listItem(itemImage: "lock", itemName: " 账号绑定", itemContent: "已绑定")
            })
            NavigationLink(destination: GeneralSettingView(), label: {
                listItem(itemImage: "gear.circle", itemName: " 通用设置", itemContent: "")
            })

            listItem(itemImage: "icloud.and.arrow.down", itemName: " 版本更新", itemContent: "Version 1.0.0")

            cleanCacheItem
            
            NavigationLink(destination: AboutView(), label: {
                listItem(itemImage: "personalhotspot", itemName: "关于", itemContent: "")
            })

        }
    }
    // 清理缓存按钮
    private var cleanCacheItem: some View {
        Button(action: {
            cleanCache()
        }) {
            HStack {
                Image(systemName: "leaf")
                    .font(.body)
                    .foregroundColor(.black)
                Text(" 清理缓存")
                    .foregroundColor(.black)
                    .font(.body)
                Spacer()
                Text(cacheSize)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.vertical, 8)
        }
        .disabled(showCleanSheet)
        .onAppear(perform: getCacheSize)
    }

    // 登出按钮
    private var logOutButton: some View {
        Button {
            showAlert.toggle()
        } label: {
            Text("退出登录")
                .padding(10)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
                .foregroundColor(.red)
                .font(.headline)
        }
    }
    // 登出按钮组件
    private var logOut: some View {
        Group {
            Button(role: .destructive) {
                withAnimation(.spring()){
                    currentUserSignedIn = false
                }
            } label: {
                Text("退出登录")
            }
            Button(role: .cancel) {
                
            } label: {
                Text("取消")
            }
        }
    }
}

//  清理缓存弹窗
struct CleanSuccessView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay(
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle")
                        .font(.largeTitle)
                    Text("清理成功")
                }
                .foregroundColor(.white)
            )
            .frame(width: 120, height: 100)
            .opacity(0.7)
            .transition(.asymmetric(insertion: .scale.animation(.spring()), removal: .opacity.animation(.spring())))
    }
}

// MARK: Functions
extension SystemSettingScreen {
    /// 栏目结构
    func listItem(itemImage: String, itemName: String, itemContent: String) -> some View {
        Button(action: {
        }) {
            HStack {
                Image(systemName: itemImage)
                    .font(.body)
                    .foregroundColor(.black)
                Text(itemName)
                    .foregroundColor(.black)
                    .font(.body)
                Spacer()
                Text(itemContent)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.vertical, 8)
        }
    }
    
    /// 获取缓存大小
    func getCacheSize() {
        DispatchQueue.global().async {
            // cache文件夹
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            // 文件夹下所有文件
            let files = FileManager.default.subpaths(atPath: cachePath!)!
            // 遍历计算大小
            var size = 0
            for file in files {
                // 文件名拼接到路径中
                let path = cachePath! + "/\(file)"
                // 取出文件属性
                do {
                    let floder = try FileManager.default.attributesOfItem(atPath: path)
                    for (key, fileSize) in floder {
                        // 累加
                        if key == FileAttributeKey.size {
                            size += (fileSize as AnyObject).integerValue
                        }
                    }
                } catch {
                    print("出错了！")
                }
            }
            let totalSize = Double(size) / 1024.0 / 1024.0
            
            DispatchQueue.main.async {
                self.cacheSize = String(format: "%.2fM", totalSize)
            }
        }
    }
    
    /// 清除缓存
    func cleanCache() {
        if !isCleaning {
            // 清理缓存的sheet动画逻辑
            isCleaning = true
            showCleanSheet = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showCleanSheet = false
                isCleaning = false
            }
            // 取出cache文件夹目录 缓存文件都在这个目录下
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            // 取出文件夹下所有文件数组
            let files = FileManager.default.subpaths(atPath: cachePath!)!
            // 遍历删除
            for file in files {
                let path = cachePath! + "/\(file)"
                if FileManager.default.fileExists(atPath: path) {
                    do {
                        try FileManager.default.removeItem(atPath: path)
                    } catch {
                        
                    }
                }
            }
        }
    }
}

struct SystemSettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SystemSettingScreen()
    }
}
