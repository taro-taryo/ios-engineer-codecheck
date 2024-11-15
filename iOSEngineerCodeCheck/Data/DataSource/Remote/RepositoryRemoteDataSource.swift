//
//  RepositoryRemoteDataSource.swift
//  iOSEngineerCodeCheck
//
//  Created by taro-taryo on 2024/11/13.
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

protocol RepositoryRemoteDataSourceProtocol {
    func fetchRepositories(
        for searchWord: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}

class RepositoryRemoteDataSource: RepositoryRemoteDataSourceProtocol {
    func fetchRepositories(
        for searchWord: String, completion: @escaping (Result<[Repository], Error>) -> Void
    ) {
        guard !searchWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            completion(.failure(AppError.network(.invalidURL)))
            return
        }

        let urlString = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard
            let encodedURLString = urlString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURLString)
        else {
            completion(.failure(AppError.network(.invalidURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(AppError.network(.requestFailed(error))))
                return
            }
            guard let data = data else {
                completion(.failure(AppError.network(.noData)))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(
                    RepositoriesResponse.self, from: data)
                completion(.success(decodedResponse.items))
            } catch {
                completion(.failure(AppError.unknown(error.localizedDescription)))
            }
        }.resume()
    }
}
