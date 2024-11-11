//
//  RepositoryListViewModelTests.swift
//  iOSEngineerCodeCheck
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

class RepositoryListViewModelTests: XCTestCase {
    var viewModel: RepositoryListViewModel!
    var stubRepositoryManager: StubRepositoryManager!

    override func setUp() {
        super.setUp()
        stubRepositoryManager = StubRepositoryManager()
        viewModel = RepositoryListViewModel(repositoryManager: stubRepositoryManager)
    }

    override func tearDown() {
        viewModel = nil
        stubRepositoryManager = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertTrue(viewModel.searchText.isEmpty, "searchText should be initially empty")
        XCTAssertTrue(viewModel.repositories.isEmpty, "repositories should be initially empty")
    }

    func testFetchRepositoriesWithValidSearchText() {
        let expectation = XCTestExpectation(description: "Repositories fetched successfully")
        stubRepositoryManager.result = .success([Repository.stub()])

        viewModel.searchRepositories { result in
            if case .success(let repositories) = result {
                XCTAssertEqual(repositories.count, 1)
                XCTAssertEqual(repositories.first?.name, "Sample Repo")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRepositoriesWithInvalidSearchText() {
        let expectation = XCTestExpectation(description: "Repositories fetch failed with error")
        stubRepositoryManager.result = .failure(AppError.network(.invalidURL))

        viewModel.searchRepositories { result in
            if case .failure(let error) = result {
                XCTAssertEqual(
                    error.localizedDescription, AppError.network(.invalidURL).localizedDescription)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchRepositoriesUpdatesRepositories() {
        let expectation = XCTestExpectation(description: "Repositories are updated")
        stubRepositoryManager.result = .success([Repository.stub()])
        viewModel.searchText = "swift"

        viewModel.searchRepositories { _ in
            DispatchQueue.main.async {
                XCTAssertEqual(self.viewModel.repositories.count, 1)
                XCTAssertEqual(self.viewModel.repositories.first?.name, "Sample Repo")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testEmptySearchTextReturnsError() {
        let expectation = XCTestExpectation(description: "Error returned for empty search text")
        stubRepositoryManager.shouldReturnErrorForEmptySearchText = true
        viewModel.searchText = ""

        viewModel.searchRepositories { _ in
            DispatchQueue.main.async {
                XCTAssertNotNil(self.viewModel.error)
                XCTAssertEqual(
                    self.viewModel.error?.localizedDescription,
                    AppError.network(.invalidURL).localizedDescription)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
