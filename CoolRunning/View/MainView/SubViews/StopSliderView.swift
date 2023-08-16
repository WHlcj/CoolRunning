
import SwiftUI

struct StopSliderView: View {
    @State var value: Double = 1
    @Binding var controlValue: Bool
    
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    
    var body: some View {
        GeometryReader { gr in
            let thumbSize = gr.size.height * 0.8
            let radius = gr.size.height * 0.5
            let minValue = gr.size.width * 0.015
            let maxValue = (gr.size.width * 0.98) - thumbSize
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Text("滑动解锁")
                            .foregroundColor(.white)
                    )
                HStack {
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .foregroundColor(Color.purple)
                        .frame(width: thumbSize, height: thumbSize)
                        .background(
                            Circle()
                                .fill(.white)
                                .frame(width: thumbSize, height: thumbSize)
                        )
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                                }
                                .onEnded { _ in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        if value != 100 {
                                            withAnimation(.easeInOut(duration: 0.3)){
                                                value = 1
                                            }
                                        } else {
                                            withAnimation(.easeInOut(duration: 0.2)){
                                                controlValue = false
                                            }
                                        }
                                    }
                                }
                        )
                    Spacer()
                }
            }
        }
    }
}

struct StopSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            //background
            Color.cyan
            
            StopSliderView(controlValue: .constant(true))
                .frame(width: 300, height: 60)
        }
    }
}
