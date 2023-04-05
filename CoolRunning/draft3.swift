
import SwiftUI


struct draft3: View {
    
    @State private var cacheSize = ""
    @State private var showCleanSheet: Bool = false
    @State private var isCleaning = false
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                header
                
                Spacer()
            }
        }
    }
    
    var header: some View {
        HStack(spacing: 12) {
            infoCell(info: "1.24km", title: "路程")
            Divider()
            infoCell(info: "4'56''", title: "时间")
            Divider()
            infoCell(info: "00:05:23", title: "时间")
            Divider()
            infoCell(info: "121", title: "步频")
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Color.white
        )
    }
    
    func infoCell(info: String, title: String) -> some View {
        VStack {
            Text(info)
                .font(.title2.bold())
            Text(title)
                .font(.body)
        }
        .foregroundColor(.black)
    }
}





struct draft3_Previews: PreviewProvider {
    static var previews: some View {
        draft3()
    }
}
