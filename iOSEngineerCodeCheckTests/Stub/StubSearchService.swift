//
//  StubSearchService.swift
//  iOSEngineerCodeCheckTests
//
//  Created by taro-taryo on 2024/11/10.
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

@testable import iOSEngineerCodeCheck

class StubSearchService: RepositoryFetchable {
    var result: Result<[Repository], Error>?
    var shouldReturnError = false
    var shouldReturnRequestFailedError = false
    var shouldReturnInvalidData = false

    func fetchRepositories(
        for searchWord: String, completion: @escaping (Result<[Repository], Error>) -> Void
    ) {
        if shouldReturnRequestFailedError {
            completion(
                .failure(
                    AppError.network(
                        .requestFailed(
                            NSError(
                                domain: "", code: -1009,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        "The request failed due to network issues."
                                ])))))
        } else if shouldReturnError {
            completion(.failure(AppError.network(.invalidURL)))
        } else if shouldReturnInvalidData {
            // 不正なJSONデータでデコードエラーを発生させる
            let invalidData = Data("invalid data".utf8)
            do {
                _ = try JSONDecoder().decode(RepositoriesResponse.self, from: invalidData)
                completion(.failure(AppError.unknown("Unexpected success on invalid data")))
            } catch {
                completion(.failure(AppError.unknown("Failed to decode response.")))
            }
        } else if let result = result {
            completion(result)
        } else {
            completion(.success([Repository.stub()]))
        }
    }
}
