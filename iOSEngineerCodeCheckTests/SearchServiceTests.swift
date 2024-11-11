//
//  SearchServiceTests.swift
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

import XCTest

@testable import iOSEngineerCodeCheck

class SearchServiceTests: XCTestCase {

    var searchService: StubSearchService!

    override func setUp() {
        super.setUp()
        searchService = StubSearchService()
    }

    override func tearDown() {
        searchService = nil
        super.tearDown()
    }

    func testFetchRepositoriesSuccess() {
        let expectation = XCTestExpectation(description: "Repositories fetched successfully")

        // 成功結果を設定
        searchService.result = .success([Repository.stub()])

        searchService.fetchRepositories(for: "swift") { result in
            if case .success(let repositories) = result {
                XCTAssertGreaterThan(repositories.count, 0)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRepositoriesInvalidURL() {
        let expectation = XCTestExpectation(
            description: "Repositories fetch failed with invalid URL error")

        // 無効なURLでエラーを返す設定
        searchService.shouldReturnError = true

        searchService.fetchRepositories(for: "") { result in
            if case .failure(let error) = result {
                XCTAssertEqual(
                    error.localizedDescription, AppError.network(.invalidURL).localizedDescription)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRepositoriesRequestFailed() {
        let expectation = XCTestExpectation(description: "Request failed error returned")

        // リクエスト失敗エラーを強制する設定
        searchService.shouldReturnRequestFailedError = true

        searchService.fetchRepositories(for: "unreachable") { result in
            if case .failure(let error) = result {
                XCTAssertTrue(
                    error.localizedDescription.contains("The request failed due to network issues"))
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
