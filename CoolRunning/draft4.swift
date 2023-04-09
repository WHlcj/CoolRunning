//
//  draft4.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/4/9.
//

import SwiftUI

struct draft4: View {
    @State var state = false
    
    var body: some View {
        VStack {      
//            switch state {
//            case true:
//                draft3(controlValue: $state)
//                    .frame(width: 200, height: 45)
//            case false:
                Button {
                    state.toggle()
                } label: {
                    Image(systemName: state ? "lock.circle.fill" : "lock.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.purple)
                        .background(
                            Circle()
                                .fill(.white)
                                .frame(width: 50, height: 50)
                        )
                }
            //}
        }
    }
}

struct draft4_Previews: PreviewProvider {
    static var previews: some View {
        draft4()
    }
}
