//
//  IngredientSelectionView.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import SwiftUI

struct IngredientSelectionView: View {
    @State private var isEmojiMode: Bool = false
    @Binding var selectedIngredients: [String] // 接收来自 ContentView 的选中的食材列表
    
    var body: some View {
        VStack {
            Text("Select Your Ingredients")
                .font(.headline)
            
            // 切换按钮
            Toggle("Emoji Menu", isOn: $isEmojiMode)
                .padding()
            
            if isEmojiMode {
                // Emoji 菜单
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(availableIngredients) { ingredient in
                        VStack {
                            Text(ingredient.emoji)
                                .font(.largeTitle)
                            Text(ingredient.name)
                                .font(.caption)
                        }
                        .padding()
                        .background(selectedIngredients.contains(ingredient.name) ? Color.blue.opacity(0.5) : Color.clear)
                        .cornerRadius(10)
                        .onTapGesture {
                            toggleIngredientSelection(ingredient.name)
                        }
                    }
                }
                .padding()
            } else {
                // 文本菜单
                List(availableIngredients) { ingredient in
                    HStack {
                        Text(ingredient.emoji)
                        Text(ingredient.name)
                        Spacer()
                        if selectedIngredients.contains(ingredient.name) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleIngredientSelection(ingredient.name)
                    }
                }
            }
        }
        .navigationTitle("Select Ingredients")
    }
    
    // 可用食材数据
    var availableIngredients: [Ingredient] {
        [
            Ingredient(name: "Chicken", emoji: "🐔"),
            Ingredient(name: "Egg", emoji: "🥚"),
            Ingredient(name: "Beef", emoji: "🥩"),
            Ingredient(name: "Tomato", emoji: "🍅"),
            Ingredient(name: "Onion", emoji: "🧅"),
            Ingredient(name: "Garlic", emoji: "🧄"),
            Ingredient(name: "Potato", emoji: "🥔"),
            Ingredient(name: "Carrot", emoji: "🥕")
        ]
    }
    
    // 选择食材的函数
    func toggleIngredientSelection(_ ingredient: String) {
        if let index = selectedIngredients.firstIndex(of: ingredient) {
            selectedIngredients.remove(at: index)
        } else {
            selectedIngredients.append(ingredient)
        }
    }
}

// 食材模型
struct Ingredient: Identifiable {
    var id = UUID()
    var name: String
    var emoji: String
}
