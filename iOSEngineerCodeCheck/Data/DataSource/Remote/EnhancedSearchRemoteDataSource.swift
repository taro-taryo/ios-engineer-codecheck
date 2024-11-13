//
//  EnhancedSearchRemoteDataSource.swift
//  iOSEngineerCodeCheck
//
//  Created by taro-taryo on 2024/11/12.
// Copyright © 2024 YUMEMI Inc. All rights reserved.
// Copyright © 2024 taro-taryo. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

protocol EnhancedSearchRemoteDataSourceProtocol {
    func fetchTopicSuggestions(
        for query: String, completion: @escaping (Result<[String], Error>) -> Void)
}

class EnhancedSearchRemoteDataSource: EnhancedSearchRemoteDataSourceProtocol {
    func fetchTopicSuggestions(
        for query: String, completion: @escaping (Result<[String], Error>) -> Void
    ) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            completion(.success([]))
            return
        }

        let urlString = "https://api.github.com/search/topics?q=\(query)&per_page=10"
        guard
            let encodedURLString = urlString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURLString)
        else {
            completion(.failure(AppError.network(.invalidURL)))
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/vnd.github.mercy-preview+json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(AppError.network(.requestFailed(error))))
                return
            }
            guard let data = data else {
                completion(.failure(AppError.network(.noData)))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(TopicResponse.self, from: data)
                let topics = decodedResponse.items.map { $0.name }
                completion(.success(topics))
            } catch {
                completion(.failure(AppError.unknown(error.localizedDescription)))
            }
        }.resume()
    }
}

struct TopicResponse: Codable {
    let items: [Topic]
}

struct Topic: Codable {
    let name: String
}