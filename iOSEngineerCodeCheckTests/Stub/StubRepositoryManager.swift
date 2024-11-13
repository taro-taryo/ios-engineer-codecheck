//
//  StubRepositoryManager.swift
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

class StubRepositoryManager: RepositoryRepositoryInterface {
    var result: Result<[Repository], Error>?
    var shouldReturnEmptyResult = false
    var shouldReturnError = false
    var shouldReturnErrorForEmptySearchText = false

    func fetchRepositories(
        for searchWord: String, completion: @escaping (Result<[Repository], Error>) -> Void
    ) {
        if shouldReturnError
            || (shouldReturnErrorForEmptySearchText
                && searchWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        {
            completion(.failure(AppError.network(.invalidURL)))
        } else if shouldReturnEmptyResult {
            completion(.success([]))
        } else if let result = result {
            completion(result)
        } else {
            let sampleRepo = Repository.stub(name: "Sample Repo", language: "Swift", stars: 100)
            completion(.success([sampleRepo]))
        }
    }
}
