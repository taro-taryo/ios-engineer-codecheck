//
//  ContentViewUITests.swift
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

import XCTest

class ContentViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testTagSuggestionsAreDisplayedBasedOnSearchText() {
        // Given
        let searchBar = app.textFields["SearchBar"]
        XCTAssertTrue(searchBar.exists)

        // When
        searchBar.tap()
        searchBar.typeText("ja")

        // Then
        let tagSuggestion = app.buttons["swift"]  // タグ候補の例
        XCTAssertTrue(
            tagSuggestion.waitForExistence(timeout: 2.0),
            "Tag suggestion should be visible based on input.")
    }

    func testRelatedTopicsAreDisplayedBasedOnSearchText() {
        // Given
        let searchBar = app.textFields["SearchBar"]
        XCTAssertTrue(searchBar.exists)

        // When
        searchBar.tap()
        searchBar.typeText("swift")

        // Then
        let relatedSuggestion = app.buttons["SwiftUI"]  // 取得した関連トピックの例
        XCTAssertTrue(
            relatedSuggestion.waitForExistence(timeout: 2.0),
            "Related topic suggestion should be visible based on input.")
    }

    func testUserCanSelectTagSuggestion() {
        // Given
        let searchBar = app.textFields["SearchBar"]
        searchBar.tap()
        searchBar.typeText("ja")

        // When
        let tagSuggestion = app.buttons["swift"]  // タグ候補の例
        XCTAssertTrue(
            tagSuggestion.waitForExistence(timeout: 2.0), "Tag suggestion should be visible.")
        tagSuggestion.tap()

        // Then
        let searchResults = app.tables["SearchResultsTable"]
        XCTAssertTrue(
            searchResults.exists,
            "Search results should be displayed after selecting a tag suggestion.")
    }

    func testUserCanSelectRelatedTopicSuggestion() {
        // Given
        let searchBar = app.textFields["SearchBar"]
        searchBar.tap()
        searchBar.typeText("swift")

        // When
        let relatedSuggestion = app.buttons["SwiftUI"]  // 関連トピックの例
        XCTAssertTrue(
            relatedSuggestion.waitForExistence(timeout: 2.0),
            "Related topic suggestion should be visible.")
        relatedSuggestion.tap()

        // Then
        let searchResults = app.tables["SearchResultsTable"]
        XCTAssertTrue(
            searchResults.exists,
            "Search results should be displayed after selecting a related topic suggestion.")
    }
}
