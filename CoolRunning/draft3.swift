//
//  draft3.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/18.
//

import SwiftUI


struct draft3: View {
    
    @State private var cacheSize = ""
    @State private var showCleanSheet: Bool = false
    @State private var isCleaning = false
    
    var body: some View {
        ZStack {
            cleanCacheItem
            sheets
        }
    }
    
    private func cleanCache() {
        if !isCleaning {
            isCleaning = true
            showCleanSheet = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showCleanSheet = false
                isCleaning = false
            }
        }
    }
    
    private var sheets: some View {
        ZStack {
            if showCleanSheet {
                CleanSuccessView()
                    .onAppear {
                        isCleaning = true
                    }
                    .onDisappear {
                        isCleaning = false
                    }
            }
        }
        .zIndex(2)
    }
    
    private var cleanCacheItem: some View {
        Button(action: cleanCache) {
            HStack {
                Image(systemName: "leaf")
                    .font(.body)
                    .foregroundColor(.black)
                Text(" 清理缓存")
                    .foregroundColor(.black)
                    .font(.body)
                Spacer()
                Text(cacheSize)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.vertical, 8)
        }
    }
}





struct draft3_Previews: PreviewProvider {
    static var previews: some View {
        draft3()
    }
}
