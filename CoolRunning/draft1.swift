
import SwiftUI

struct draft1: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HeaderView()
            }
        }
        .coordinateSpace(name: "Scroll")
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("Scroll")).minY
            let size = proxy.size
            let height = (size.height + minY)
            
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
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ARTIST")
                                .font(.callout)
                                .foregroundColor(.gray)
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("Ariana Grande")
                                    .font(.title.bold())
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                //  label中勾号的背景
                                    .background(content: {
                                        Circle()
                                            .fill(.white)
                                            .padding(3)
                                    })
                            }
                        }
                        .padding([.leading, .bottom])
                    }
                })
                .cornerRadius(15)
                .offset(y: -minY)
        }
        .frame(height: 250)
    }
}

struct draft1_Previews: PreviewProvider {
    static var previews: some View {
        draft1()
    }
}
