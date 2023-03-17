
import SwiftUI
import PhotosUI

struct draft1: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
           VStack {
               PhotosPicker(
                   selection: $selectedItem,
                   matching: .images,
                   photoLibrary: .shared()) {
                       Text("Select a photo")
                   }
                   .onChange(of: selectedItem) { newItem in
                       Task {
                           if let data = try? await newItem?.loadTransferable(type: Data.self) {
                               selectedImageData = data
                           }
                       }
                   }
               Image("me")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 100)
                   .clipShape(Circle())
                   .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 1))
               if let selectedImageData,
                  let uiImage = UIImage(data: selectedImageData) {
                   Image(uiImage: uiImage)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 100, height: 100)
                       .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 1))
               }
           }
       }
}

struct draft1_Previews: PreviewProvider {
    static var previews: some View {
        draft1()
    }
}
