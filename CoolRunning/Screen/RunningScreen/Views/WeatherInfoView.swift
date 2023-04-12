//
//  WeatherInfoView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/4/12.
//

import SwiftUI

struct WeatherInfoView: View {
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        VStack {
            if vm.isLoaded {
                HStack {
                    Image(vm.icon)
                        .resizable()
                    VStack {
                        Text(vm.text)
                        Text(vm.temp)
                    }
                    .foregroundColor(.gray)
                }
            } else {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .onAppear {
            if !vm.isRequested {
                vm.inquireWeather()
            }
        }
    }
}

struct WeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoView()
    }
}
