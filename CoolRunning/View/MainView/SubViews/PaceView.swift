
import SwiftUI
import CoreMotion

struct PaceView: View {

    @State private var stepCount: Int = 0 // 步数
    @State private var lastUpdate: Date? = nil // 最后更新时间
    @State private var strideLength: Double? = nil // 步长

    let motionManager = CMMotionManager()
    let pedometer = CMPedometer()

    var body: some View {
        VStack {
            Text("Step Count: \(stepCount)")
            Text("Stride Length: \(strideLength ?? 0, specifier: "%.2f") meters")
        }
        .onAppear {
            startPedometerUpdates()
            calculateStride()
        }
    }

    func startPedometerUpdates() { // 开始获取计步数据
        guard CMPedometer.isStepCountingAvailable() else { // 判断 CMPedometer 是否可用
            print("Pedometer data is not available on this device.")
            return
        }
        pedometer.startUpdates(from: Date(), withHandler: { pedometerData, error in // 开始获取计步数据
            if let data = pedometerData { // 判断获取数据是否成功
                self.stepCount = data.numberOfSteps.intValue // 更新步数
                if let lastUpdate = self.lastUpdate { // 获取最后更新时间
                    let interval = data.endDate.timeIntervalSince(lastUpdate) // 计算时间间隔
                    let stepFrequency = Int(Double(data.numberOfSteps.intValue) / interval) // 计算步频
                    print("Step Frequency: \(stepFrequency) steps per second") // 打印步频
                }
                self.lastUpdate = data.endDate // 更新最后更新时间
            }
            if let error = error { // 判断是否有错误
                print("Error getting pedometer data: \(error.localizedDescription)") // 打印错误信息
            }
        })
    }

    func calculateStride() { // 计算步长
        guard motionManager.isDeviceMotionAvailable else { // 判断 CMMotionManager 是否可用
            print("Device motion data is not available on this device.") // 如果不可用则显示错误信息
            return
        }
        motionManager.deviceMotionUpdateInterval = 0.1 // 设置运动数据更新间隔
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { data, error in // 开始获取设备运动数据
            if let data = data {
                let accelerationX = data.userAcceleration.x // 获取加速度 x 分量
                let accelerationY = data.userAcceleration.y // 获取加速度 y 分量
                let accelerationZ = data.userAcceleration.z // 获取加速度 z 分量
                let acceleration = sqrt(pow(accelerationX, 2) + pow(accelerationY, 2) + pow(accelerationZ, 2)) // 计算加速度大小
                let stride = (acceleration / 9.81) * 0.46 // 计算步长（该公式需要根据不同人体特征进行调整）
                self.strideLength = stride // 更新步长
            }
            if let error = error { // 判断是否有错误
                print("Error getting device motion data: \(error.localizedDescription)") // 打印错误信息
            }
        }
    }
}

struct PaceView_Previews: PreviewProvider {
    static var previews: some View {
        PaceView()
    }
}
