//
//  RepositoryRowUITests.swift
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

class RepositoryRowUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testRepositoryRowDisplaysPopularityIndicators() {
        // Assume the repository row is present on the initial screen for simplicity
        let repositoryRow = app.staticTexts["Test Repository"]
        XCTAssertTrue(repositoryRow.exists, "Repository row should be visible.")

        // Check for stars, forks, and watchers indicators
        let starBadge = repositoryRow.otherElements["star.fill"]
        let forkBadge = repositoryRow.otherElements["tuningfork"]
        let watchersLabel = repositoryRow.otherElements["eye.fill"]

        XCTAssertTrue(starBadge.exists, "Star badge should be visible.")
        XCTAssertTrue(forkBadge.exists, "Fork badge should be visible.")
        XCTAssertTrue(watchersLabel.exists, "Watchers label should be visible.")
    }

    func testPopularityIndicatorsHaveCorrectColorsAndStyle() {
        // Locate badges and labels
        let starBadge = app.staticTexts["star.fill"]
        let forkBadge = app.staticTexts["tuningfork"]
        let openIssuesBadge = app.staticTexts["exclamationmark.triangle.fill"]

        XCTAssertEqual(starBadge.labelColor, UIColor.yellow, "Star badge should have yellow text.")
        XCTAssertEqual(forkBadge.labelColor, UIColor.blue, "Fork badge should have blue text.")
        XCTAssertEqual(
            openIssuesBadge.labelColor, UIColor.orange, "Open issues badge should have orange text."
        )
    }
}
