//
//  ContentViewModel.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    // @Published 修饰的变量会在数据发生变化时通知视图更新
    @Published var foodName: String = ""          // 用于搜索的食物名称
    @Published var searchResults: [Product] = []  // 保存从 API 获取的产品列表
    @Published var isLoading: Bool = false        // 用于控制加载状态
    @Published var errorMessage: String? = nil    // 保存错误信息
    @Published var selectedIngredients: [String] = []  // 用户选择的食材
    @Published var recipeSuggestions: [String] = []    // 推荐的食谱

    // 调用 API 搜索食物
    func searchFood() {
        guard !foodName.isEmpty else {
            errorMessage = "Food name cannot be empty."
            return
        }

        isLoading = true
        errorMessage = nil
        
        // 调用 APIManager 中的搜索功能
        APIManager.shared.searchFood(keyword: foodName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let products):
                    self?.searchResults = products
                case .failure(let error):
                    self?.errorMessage = "Failed to load results: \(error.localizedDescription)"
                }
            }
        }
    }

// 推荐食谱
    func recommendRecipes() {
        // 简单的食谱推荐逻辑
        if selectedIngredients.isEmpty {
            recipeSuggestions = []
        } else {
            recipeSuggestions = ["Recipe 1 with \(selectedIngredients.joined(separator: ", "))", "Recipe 2", "Recipe 3"]
        }
    }
}

