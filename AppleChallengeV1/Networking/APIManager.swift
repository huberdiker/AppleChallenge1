//
//  APIManager.swift
//  AppleChallengeV1
//
//  Created by 张麦根 on 2024/10/09.
//

import Foundation

class APIManager {
    static let shared = APIManager()

    func searchFood(keyword: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://world.openfoodfacts.org/cgi/search.pl?search_terms=\(keyword)&search_simple=1&action=process&json=1") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(OpenFoodFactsResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedResponse.products))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}

struct OpenFoodFactsResponse: Codable {
    let products: [Product]
}

