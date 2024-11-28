//
//  ContentView.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()  // 处理搜索逻辑
    @State private var showPersonalInfoForm: Bool = false    // 控制个人信息表单显示

    var body: some View {
        TabView {
            // 第一栏: 食材选择
            VStack {
                IngredientSelectionView(selectedIngredients: $viewModel.selectedIngredients)
                    .padding()

                Button(action: {
                    viewModel.recommendRecipes()
                }) {
                    Text("Get Recipe Suggestions")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if !viewModel.recipeSuggestions.isEmpty {
                    Text("Recommended Recipes:")
                        .font(.headline)
                        .padding(.top)

                    List(viewModel.recipeSuggestions, id: \.self) { recipe in
                        Text(recipe)
                    }
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Ingredients")
            }

            // 第二栏: API 搜索栏
            VStack {
                TextField("Search for food...", text: $viewModel.foodName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 300)

                Button(action: {
                    viewModel.searchFood()
                }) {
                    Text("Search")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(viewModel.searchResults) { product in
                        VStack(alignment: .leading) {
                            Text(product.productName ?? "Unknown Product")
                                .font(.headline)
                            if let brands = product.brands {
                                Text("Brand: \(brands)")
                                    .font(.subheadline)
                            }
                            if let nutrients = product.nutriments {
                                Text("Energy: \(nutrients.energyKcal ?? 0) kcal")
                            }
                        }
                        .onTapGesture {
                            if let productName = product.productName {
                                viewModel.selectedIngredients.append(productName)
                            }
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }

            // 第三栏: 设置
            VStack {
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
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .sheet(isPresented: $showPersonalInfoForm) {
            PersonalInfoForm(showPersonalInfoForm: $showPersonalInfoForm)
        }
    }
}

// 预览结构体，放在文件的底部，展示 ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
