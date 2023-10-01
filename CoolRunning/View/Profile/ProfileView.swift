
import SwiftUI

struct ProfileView: View {
    /// App导航路由
    @Binding var path: NavigationPath
    // 用户信息
    @AppStorage("user_image") var userImage: String = "me"
    @AppStorage("user_name") var userName: String = "Elee"
    @AppStorage("user_motto") var userMotto: String = "不抱希望，不抱月亮～"
    
    var body: some View {
        ScrollView {
            VStack {
                headerView
            }
        }
        .coordinateSpace(name: "Scroll")
        .ignoresSafeArea(.container, edges: .vertical)
        .toolbar {
            systemBar
        }
    }
}

// MARK: Components
extension ProfileView {
    // 顶部信息
    var headerView: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("Scroll")).minY
            let size = proxy.size
            let height = (size.height + minY)
            // 拉伸背景图
            Image("girl")
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        // 调暗背景图
                        LinearGradient(colors: [
                            .clear,
                            .black.opacity(0.8)
                        ], startPoint: .top, endPoint: .bottom)
                        // 展示信息
                        userInforView
                    }
                })
                .cornerRadius(15)
                .offset(y: -minY)
        }
        .frame(height: 300)
    }
    // 用户信息
    var userInforView: some View {
        HStack( spacing: 20) {
            // 用户头像信息
            userImageInfo
            // 头像右侧信息
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center, spacing: 10) {
                    Text(userName)
                        .font(.title.bold())
                }
                Text(userMotto)
                    .font(.callout)
                    .foregroundColor(.gray)
                HStack(spacing: 15) {
                    socialInfoDetail(title: "粉丝数", value: "10K")
                    Divider()
                    socialInfoDetail(title: "点赞数", value: "20K")
                    Divider()
                    socialInfoDetail(title: "关注数", value: "50")
                }
            }
            .frame(height: 40)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.horizontal ,.bottom])
    }
    // 用户头像信息
    var userImageInfo: some View {
        VStack(spacing: 10) {
            Image(userImage)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)
            
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
                    .background(content: {
                        Circle()
                            .fill(.white)
                            .padding(3)
                    })
                Text("已认证")
                    .font(.callout)
                    .padding(.leading, -5)
            }
        }
    }
    // 社交信息组成
    func socialInfoDetail(title: String, value: String) -> some View  {
        VStack {
            Text(value)
                .font(.headline)
                .padding(.bottom, 4)
            Text(title)
                .font(.subheadline)
        }
    }
    // 设置按钮
    private var systemBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(value: AppRouter.SystemSettingView) {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .navigationDestination(for: AppRouter.self) { page in
                ContentView(view: page, path: $path)
            }
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        ProfileView(path: $path)
    }
}
