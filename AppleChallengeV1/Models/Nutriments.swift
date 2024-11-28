//
//  Nutriments.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import Foundation

// 营养信息模型
struct Nutriments: Codable {
    let energyKcal: Double?      // 能量（千卡）
    let protein: Double?         // 蛋白质
    let fat: Double?             // 脂肪
    let carbohydrates: Double?   // 碳水化合物
    let sugars: Double?          // 糖分
    let fiber: Double?           // 纤维
    let salt: Double?            // 盐

    enum CodingKeys: String, CodingKey {
        case energyKcal = "energy-kcal_100g"
        case protein = "proteins_100g"
        case fat = "fat_100g"
        case carbohydrates = "carbohydrates_100g"
        case sugars = "sugars_100g"
        case fiber = "fiber_100g"
        case salt = "salt_100g"
    }
}

