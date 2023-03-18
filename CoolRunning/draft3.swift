//
//  draft3.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/18.
//

import SwiftUI

struct draft3: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 头部视图
                HeaderView()
                    .frame(height: 250)
                
                // 用户信息
                VStack(spacing: 15) {
                    Image("avatar")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 7)
                    
                    Text("Elee")
                        .font(.title)
                    
                    Text("iOS底层分子")
                        .font(.body)
                }
                
                Divider()
                
                // 社交信息
                VStack(spacing: 15) {
                    Text("社交信息")
                        .font(.title2)
                    
                    HStack(spacing: UIScreen.main.bounds.width/4) {
                        socialInfoDetail(title: "粉丝数", value: "10K")
                        socialInfoDetail(title: "点赞数", value: "20K")
                        socialInfoDetail(title: "关注数", value: "50")
                    }
                }
                
                Divider()
                
                // 个人简介
                VStack(spacing: 10) {
                    Text("个人简介")
                        .font(.title2)
                    
                    Text("这里是个人简介")
                        .font(.body)
                }
                
                Divider()
                
                // 照片墙
                VStack(spacing: 10) {
                    Text("照片墙")
                        .font(.title2)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(1...10, id: \.self) { index in
                                Image("photo\(index)")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            
            

            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // 社交信息组成
    func socialInfoDetail(title: String, value: String) -> some View  {
        VStack {
            Text(value)
                .font(.headline)
            
            Text(title)
                .font(.subheadline)
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        // 这里写头部视图的代码，和你之前的代码差不多
        // ...
    }
}


struct draft3_Previews: PreviewProvider {
    static var previews: some View {
        draft3()
    }
}
