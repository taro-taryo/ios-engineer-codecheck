//
//  RepositoryManagerTests.swift
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

class RepositoryManagerTests: XCTestCase {
    var repositoryManager: RepositoryManager!
    var stubSearchService: StubSearchService!

    override func setUp() {
        super.setUp()
        stubSearchService = StubSearchService()
        repositoryManager = RepositoryManager(searchService: stubSearchService)
    }

    override func tearDown() {
        repositoryManager = nil
        stubSearchService = nil
        super.tearDown()
    }

    func testFetchRepositoriesSuccess() {
        let expectation = XCTestExpectation(description: "Repositories fetched successfully")
        stubSearchService.result = .success([Repository.stub()])

        repositoryManager.fetchRepositories(for: "swift") { result in
            if case .success(let repositories) = result {
                XCTAssertEqual(repositories.count, 1)
                XCTAssertEqual(repositories.first?.name, "Sample Repo")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRepositoriesFailure() {
        let expectation = XCTestExpectation(description: "Repositories fetch failed with error")
        stubSearchService.result = .failure(AppError.network(.invalidURL))

        repositoryManager.fetchRepositories(for: "invalid") { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, AppError.network(.invalidURL).localizedDescription)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testEmptySearchWordReturnsError() {
        let expectation = XCTestExpectation(description: "Error returned for empty search word")

        repositoryManager.fetchRepositories(for: "") { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, AppError.network(.invalidURL).localizedDescription)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
