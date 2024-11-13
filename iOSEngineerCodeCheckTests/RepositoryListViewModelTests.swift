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

import Combine
import XCTest

@testable import YourApp

class RepositoryListViewModelTests: XCTestCase {

    var viewModel: RepositoryListViewModel!
    var mockFetchRepositoriesUseCase: MockFetchRepositoriesUseCase!
    var mockEnhancedSearchService: MockEnhancedSearchService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockFetchRepositoriesUseCase = MockFetchRepositoriesUseCase()
        mockEnhancedSearchService = MockEnhancedSearchService()
        viewModel = RepositoryListViewModel(
            fetchRepositoriesUseCase: mockFetchRepositoriesUseCase,
            enhancedSearchService: mockEnhancedSearchService
        )
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockFetchRepositoriesUseCase = nil
        mockEnhancedSearchService = nil
        cancellables = nil
        super.tearDown()
    }

    func testTagSuggestionsAreUpdatedBasedOnSearchText() {
        // Given
        let expectedTagSuggestions = ["swift", "javascript"]
        viewModel.searchText = "ja"

        // When
        viewModel.updateTagSuggestions(for: viewModel.searchText)

        // Then
        XCTAssertEqual(viewModel.tagSuggestions, expectedTagSuggestions)
    }

    func testRelatedSuggestionsAreFetchedFromEnhancedSearchService() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch related suggestions")
        let expectedRelatedSuggestions = ["iOS", "SwiftUI", "Combine"]

        mockEnhancedSearchService.fetchSuggestionsResult = .success(expectedRelatedSuggestions)

        viewModel.$relatedSuggestions
            .dropFirst()
            .sink { suggestions in
                XCTAssertEqual(suggestions, expectedRelatedSuggestions)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.fetchRelatedSuggestions(for: "swift")

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
