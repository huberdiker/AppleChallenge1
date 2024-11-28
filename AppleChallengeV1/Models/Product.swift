//
//  Product.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: String {code}// 实现 Identifiable 协议
    let code: String
    let productName: String?
    let brands: String?
    let nutriments: Nutriments?
    
    enum CodingKeys: String, CodingKey {
        case code
        case productName = "product_name"
        case brands
        case nutriments
    }
}
