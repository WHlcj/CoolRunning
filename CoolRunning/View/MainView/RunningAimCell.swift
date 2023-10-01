
import SwiftUI

struct RunningAimCell: View {
    
    /// 设立的跑步目标公里数
    @State var runningGoal = 126.0
    /// 用户已跑的公里数
    @State var reachedDistance = 120.136
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            cellTopText
            runningProgressBar
            cellBottomText
        }
        .padding()
        .background(
            ZStack {
                Color.white
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.purple, lineWidth: 3)
            }
        )
    }
}

extension RunningAimCell {
    
    /// 跑步信息顶部文字信息
    var cellTopText: some View {
        HStack(alignment: .bottom) {
            SFSymbol.run
                .font(.title.bold())
            Text(String(format: "%.2f", reachedDistance))
                .font(.title.bold())
            Text("公里")
                .padding(.bottom, 3)
        }
        .foregroundColor(.black)
        .opacity(0.8)
    }
    /// 跑步进度条
    var runningProgressBar: some View {
        ProgressView(value: reachedDistance/runningGoal)
            .tint(.purple)
            .padding(3)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple, lineWidth: 1.5)
            )
    }
    /// 跑步信息底部文字信息
    var cellBottomText: some View {
        HStack {
            Text("学期目标:")
                .foregroundColor(.gray)
            Text(String(format: "%.0f", runningGoal) + "公里")
                .opacity(0.8)
        }
    }
}

struct RunningAimCell_Previews: PreviewProvider {
    static var previews: some View {
        RunningAimCell()
    }
}
