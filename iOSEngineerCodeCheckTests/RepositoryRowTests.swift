//
//  RepositoryRowTests.swift
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

import SwiftUI
import XCTest

@testable import iOSEngineerCodeCheck

class RepositoryRowTests: XCTestCase {
    func testRepositoryRowDisplaysCorrectData() {
        // Arrange
        let repository = RepositoryViewData(
            id: UUID(), name: "Test Repository", language: "Swift", stars: 100, watchers: 200,
            forks: 50, openIssues: 10, ownerAvatarURL: nil)
        let repositoryRow = RepositoryRow(repository: repository)

        // Act
        let hostingController = UIHostingController(rootView: repositoryRow)

        // Assert
        XCTAssertEqual(
            repositoryRow.repository.name, "Test Repository",
            "Repository name should match the provided value.")
        XCTAssertEqual(
            repositoryRow.repository.language, "Swift",
            "Repository language should match the provided value.")
        XCTAssertEqual(
            repositoryRow.repository.stars, 100,
            "Repository stars count should match the provided value.")
        XCTAssertEqual(
            repositoryRow.repository.forks, 50,
            "Repository forks count should match the provided value.")
        XCTAssertEqual(
            repositoryRow.repository.openIssues, 10,
            "Repository open issues count should match the provided value.")
    }
}
