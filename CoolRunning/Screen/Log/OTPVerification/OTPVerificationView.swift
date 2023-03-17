//
//  OTPVerificationView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/8.
//

import SwiftUI

struct OTPVerificationView: View {
    
    @State private var otpText: String = ""
    // Keyboard State
    @FocusState private var isKeyboardShowing: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            otpTextBoxes
            otpButton
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: Components
extension OTPVerificationView {
    var otpTextBoxes: some View {
        VStack(alignment: .leading) {
            Text("短信验证码")
                .font(.largeTitle)
            HStack {
                // OTP Text Boxes
                ForEach(0..<6, id: \.self) { index in
                    OTPBoxes(index)
                }
            }

            .background(
                TextField("", text: $otpText.limit(6))
                    .keyboardType(.numberPad)
                // To show the most recent one-time code from message
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1) //不能删，防止误触崩溃
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            )
            .contentShape(Rectangle()) // help the tap
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
        }
        .padding(.horizontal, 10)
        .toolbar {
            ToolbarItem(placement: .keyboard, content: {
                Button("Done") {
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            })
        }
    }
    
    var otpButton: some View {
        VStack {
            Button {

            } label: {
                Text("验证")
                    .font(.title2)
                    .bold()
                    .frame(height: 30)
                    .frame(maxWidth: UIScreen.main.bounds.width)
            }
            .controlSize(.large)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .buttonStyle(.borderedProminent)
            .disabled(otpText.count < 6)
        }
        .padding(.top)
    }
    
}

// MARK: Functions
extension OTPVerificationView {
    func OTPBoxes(_ index: Int) -> some View {
        let status = isKeyboardShowing && otpText.count == index
        return ZStack {
            if otpText.count > index {
                // Finding Char At Index
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            }
        }
        .frame(width: 45, height: 45)
        .background(
            // Highlight Current Active Box
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? .purple : .gray, lineWidth: status ? 1 : 0.5)
        )
        .frame(maxWidth: .infinity)
    }
}

struct OTPverificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
