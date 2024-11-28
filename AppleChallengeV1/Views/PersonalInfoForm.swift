//
//  PersonalInfoForm.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import SwiftUI

struct PersonalInfoForm: View {
    @AppStorage("hasEnteredPersonalInfo") private var hasEnteredPersonalInfo: Bool = false
    @State private var name: String = ""
    @State private var selectedAge: Int = 18
    @State private var selectedHeight: Int = 170
    @State private var selectedWeight: Int = 65
    @Binding var showPersonalInfoForm: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("Enter Personal Information")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()

                Form {
                    Section(header: Text("Personal Information")) {
                        TextField("Name", text: $name)
                            .autocapitalization(.words)

                        // 年龄选择
                        Picker("Age", selection: $selectedAge) {
                            ForEach(1..<101, id: \.self) { age in
                                Text("\(age) years old")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())

                        // 身高选择
                        Picker("Height (cm)", selection: $selectedHeight) {
                            ForEach(100..<251, id: \.self) { height in
                                Text("\(height) cm")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())

                        // 体重选择
                        Picker("Weight (kg)", selection: $selectedWeight) {
                            ForEach(30..<201, id: \.self) { weight in
                                Text("\(weight) kg")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }

                HStack {
                    // 跳过按钮
                    Button(action: {
                        hasEnteredPersonalInfo = false
                        showPersonalInfoForm = false
                    }) {
                        Text("Skip")
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding()

                    // 提交按钮
                    Button(action: {
                        hasEnteredPersonalInfo = true
                        showPersonalInfoForm = false
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(name.isEmpty) // 只验证姓名，其他有默认值
                }
            }
            .navigationTitle("Personal Info")
        }
    }
}

