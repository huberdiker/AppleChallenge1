//
//  SettingsView.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("name") private var name: String = ""
    @AppStorage("age") private var age: Int = 18
    @AppStorage("height") private var height: Int = 170
    @AppStorage("weight") private var weight: Int = 65
    @Binding var showPersonalInfoForm: Bool

    var body: some View {
        VStack {
            Text("Settings")
                .font(.headline)
                .padding()
            
            // 显示个人信息
            Text("Name: \(name)")
            Text("Age: \(age) years old")
            Text("Height: \(height) cm")
            Text("Weight: \(weight) kg")
            
            // 计算 BMI
            let bmi = calculateBMI(weight: weight, height: height)
            Text("BMI: \(String(format: "%.2f", bmi))")
                .padding()

            // 更新个人信息按钮
            Button(action: {
                showPersonalInfoForm = true
            }) {
                Text("Enter or Update Personal Information")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    
    // 计算 BMI
    func calculateBMI(weight: Int, height: Int) -> Double {
        let heightInMeters = Double(height) / 100.0
        return Double(weight) / (heightInMeters * heightInMeters)
    }
}

