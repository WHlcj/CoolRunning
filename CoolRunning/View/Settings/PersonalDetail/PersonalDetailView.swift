
// TO DO
/*
 1.性别选择
 */

import SwiftUI
import PhotosUI


// MARK: 个人资料详情页
struct PersonalDetailView: View {
    
    // 用户信息
    @AppStorage("user_image") var userImage: String = "me"
    @AppStorage("user_alias") var userName: String = "Elee"
    @AppStorage("user_motto") var userMotto: String = "IOS底层分子"
    @AppStorage("user_height") var userHeight: Int = 0
    @AppStorage("user_weight") var userWeight: Int = 0
    @AppStorage("user_gender") var userGender: String = "男"
    @AppStorage("user_birthday") var userBirthday: String = ""

    // 控制信息
    @State private var showMottoSheet = false
    @State private var showDetailSwitches = false
    @State private var showWeightSheet = false
    @State private var showHeightSheet = false
    @State private var showBirthdaySheet = false
    @State private var selectedDate: Date = Date()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
 
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Form {
                    topUserImage
                    generalInformation
                    departmentInformation
                    privacyInformation
                }
            }
            sheets
        }
        .navigationBarTitle("个人信息", displayMode: .inline)
    }
}

// MARK: Components
extension PersonalDetailView {
    // 顶部头像
    private var topUserImage: some View {
        Section {} header: {
            VStack {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .modifyImage()
                        } else {
                            Image(userImage)
                                .resizable()
                                .modifyImage()
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
              
                        }
                    }
            }
            .frame(maxWidth: .infinity)
        }
    }
    // 基本信息
    private var generalInformation: some View {
        Section {
            listItem(itemImage: "", itemName: "用户昵称", itemContent: userName)
            listItem(itemImage: "", itemName: "学校", itemContent: "北京信息科技大学")
            listItem(itemImage: "", itemName: "学号", itemContent: "20201010903")
            listItem(itemImage: "", itemName: "性别", itemContent: userGender)
            ActionListItem(itemImage: "", itemName: "个性签名", itemContent: userMotto, actionBool: $showMottoSheet)
        } header: {
            Text("基本信息")
        }
    }
    // 院系信息
    private var departmentInformation: some View {
        Section {
            listItem(itemImage: "", itemName: "校区", itemContent: "北京信息科技大学 昌平校区")
            listItem(itemImage: "", itemName: "院系", itemContent: "计算机学院")
            listItem(itemImage: "", itemName: "班级", itemContent: "软工2101")
            listItem(itemImage: "", itemName: "入学年份", itemContent: "2101")
        } header: {
            Text("院系信息")
        }
    }
    // 隐私信息 (非公开)
    private var privacyInformation: some View {
        Section {
            ActionListItem(itemImage: "", itemName: "生日", itemContent: userBirthday, actionBool: $showBirthdaySheet)
            
            ActionListItem(itemImage: "", itemName: "身高", itemContent: "\(userHeight+150)cm", actionBool: $showHeightSheet)
            
            ActionListItem(itemImage: "", itemName: "体重", itemContent: "\(userWeight+40)kg", actionBool: $showWeightSheet)

        } header: {
            Text("隐私信息 (非公开)")
        }
    }
    
    private var sheets: some View {
        ZStack {
            if showHeightSheet {
                heightSheet
            }
            if showWeightSheet {
                weightSheet
            }
            if showBirthdaySheet {
                birthdaySheet
            }
            if showMottoSheet {
                mottoSheet
            }
        }
        .zIndex(2)
    }
    
    // 日期格式化
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    // 生日修改sheet
    private var birthdaySheet: some View {
        userBirthday = dateFormatter.string(from: selectedDate)
        return ZStack {
            // background
            Color.white
                .ignoresSafeArea()
            // content
            VStack {
                SheetTopButton(bool: $showBirthdaySheet)
                DatePicker("Select a Date", selection: $selectedDate, displayedComponents: [.date])
                    .tint(.cyan)
                    .datePickerStyle(.graphical)
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.2, maxHeight:  UIScreen.main.bounds.height / 2)
            }
        }
        .padding(.top, UIScreen.main.bounds.height/2.8)
        .transition(.move(edge: .bottom))
    }
    // 身高修改sheet
    private var heightSheet: some View {
        ZStack(alignment: .topLeading) {
            // background
            Color.white
                .ignoresSafeArea()
            // content
            VStack {
                SheetTopButton(bool: $showHeightSheet)
                HStack {
                    Picker("user_height", selection: $userHeight) {
                        ForEach(150..<211) { number in
                            Text("\(number)")
                                .font(.headline)
                                .tag("\(number)")
                        }
                    }
                    .pickerStyle(.inline)
                    .frame(maxWidth: UIScreen.main.bounds.width/2)
                    Text("cm")
                    }
            }
        }
        .padding(.top, UIScreen.main.bounds.height/1.8) // 修改sheet的高度
        .transition(.move(edge: .bottom))
    }
    // 体重修改sheet
    private var weightSheet: some View {
         ZStack(alignment: .topLeading) {
             // background
             Color.white
                 .ignoresSafeArea()

             // content
             VStack {
                 SheetTopButton(bool: $showWeightSheet)
                 HStack {
                     Picker("user_weight", selection: $userWeight) {
                         ForEach(40..<150) { weight in
                             Text("\(weight)")
                                 .font(.headline)
                                 .tag("\(weight)")
                         }
                     }
                     .pickerStyle(.inline)
                     .frame(maxWidth: UIScreen.main.bounds.width/2)
                     Text("kg")
                 }
             }
         }
         .padding(.top, UIScreen.main.bounds.height/1.8) // 修改sheet的高度
         .transition(.move(edge: .bottom))
     }
    // 座右铭修改sheet
    private var mottoSheet: some View {
        ZStack(alignment: .topLeading) {
            // background
            Color.white
                .ignoresSafeArea()
            
            // content
            VStack {
                SheetTopButton(bool: $showMottoSheet)
                TextEditor(text: $userMotto)
                    .frame(height: 180)
                    .cornerRadius(10)
                    .colorMultiply(Color.gray)
                    .opacity(0.3)
                    .padding(20)
                Spacer()
            }
        }
        .padding(.top, UIScreen.main.bounds.height/2.3) // 修改sheet的高度
        .transition(.move(edge: .bottom))
    }

}

// MARK: Functions
extension PersonalDetailView {
    /// 无Action的栏目结构
    func listItem(itemImage: String, itemName: String, itemContent: String) -> some View {
        Button(action: {
        }) {
            HStack {
                Image(systemName: itemImage)
                    .font(.body)
                    .foregroundColor(.black)
                Text(itemName)
                    .foregroundColor(.black)
                    .font(.body)
                Spacer()
                Text(itemContent)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.vertical, 8)
        }
    }
    /// Button的label部分
    func buttonLabel(itemImage: String, itemName: String, itemContent: String) -> some View {
        HStack {
            Image(systemName: itemImage)
                .font(.body)
                .foregroundColor(.black)
            Text(itemName)
                .foregroundColor(.black)
                .font(.body)
            Spacer()
            Text(itemContent)
                .font(.subheadline)
                .foregroundColor(.gray)
        }.padding(.vertical, 8)
    }
 
}

/// 有Action 的 栏目结构
struct ActionListItem: View {
    
    var itemImage: String
    var itemName: String
    var itemContent: String
    @Binding var actionBool: Bool
    
    var body: some View {
        Button {
            withAnimation(.spring()){
                actionBool.toggle()
            }
        } label: {
            buttonLabel(itemImage: itemImage, itemName: itemName, itemContent: itemContent)
        }
    }
}
extension ActionListItem {
    /// Button的label部分
    func buttonLabel(itemImage: String, itemName: String, itemContent: String) -> some View {
        HStack {
            Image(systemName: itemImage)
                .font(.body)
                .foregroundColor(.black)
            Text(itemName)
                .foregroundColor(.black)
                .font(.body)
            Spacer()
            Text(itemContent)
                .font(.subheadline)
                .foregroundColor(.gray)
        }.padding(.vertical, 8)
    }
}

/// sheetTop Button
struct SheetTopButton: View {
    @Binding var bool: Bool
    var body: some View {
        HStack {
            Button(action: {
                bool.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(.horizontal, 20)
            })
            Spacer()
            Button(action: {
                bool.toggle()
            }, label: {
                Text("保存")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding(.horizontal, 20)
            })
        }
        .padding(.top, 10)
    }
}

struct PersonalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailView()
    }
}
