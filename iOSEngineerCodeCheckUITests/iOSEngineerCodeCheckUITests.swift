//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSearchRepositories() {
        // テスト用DIContainerの設定
        let testContainer = DIContainer()
        testContainer.register(
            StubRepositoryManager() as RepositoryFetchable, for: RepositoryFetchable.self)
        testContainer.register(StubImageService() as ImageFetchable, for: ImageFetchable.self)

        // アプリの初期化と起動
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        // 検索バーにテキストを入力し、リポジトリを検索
        let searchBarField = app.otherElements["searchBarField"]
        XCTAssertTrue(
            searchBarField.waitForExistence(timeout: 5), "Search bar field should be present")
        searchBarField.tap()
        searchBarField.typeText("Swift")

        app.keyboards.buttons["search"].tap()

        // リポジトリリストの確認
        let repositoryList = app.collectionViews["repositoryList"]
        XCTAssertTrue(
            repositoryList.waitForExistence(timeout: 5),
            "Repository list should appear after search")

        // 最初のリポジトリ行が存在することを確認
        let firstRepositoryRow = repositoryList.cells.element(boundBy: 0)
        XCTAssertTrue(firstRepositoryRow.exists, "First repository row should exist")

        // 最初のリポジトリ行内の repositoryName と repositoryLanguage 要素を特定し、存在を確認
        let repositoryName = firstRepositoryRow.staticTexts["repositoryName_swiftlang/swift"]
        let repositoryLanguage = firstRepositoryRow.staticTexts["repositoryLanguage_C++"]
        XCTAssertTrue(repositoryName.exists, "Repository name should be displayed in the row")
        XCTAssertTrue(
            repositoryLanguage.exists, "Repository language should be displayed in the row")
    }

    func testDetailViewDisplay() {
        // テスト用DIContainerの設定
        let testContainer = DIContainer()
        testContainer.register(
            StubRepositoryManager() as RepositoryFetchable, for: RepositoryFetchable.self)
        testContainer.register(StubImageService() as ImageFetchable, for: ImageFetchable.self)

        // アプリの初期化と起動
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        // 検索バーにアクセスし、検索テキストを入力する
        let searchBarField = app.otherElements["searchBarField"]
        searchBarField.tap()
        searchBarField.typeText("Swift")
        app.keyboards.buttons["search"].tap()

        // リポジトリリストの表示確認と最初のリポジトリ行の選択
        let repositoryList = app.collectionViews["repositoryList"]
        XCTAssertTrue(repositoryList.waitForExistence(timeout: 5))
        let firstRepositoryRow = repositoryList.cells.element(boundBy: 0)
        XCTAssertTrue(firstRepositoryRow.exists, "First repository row should exist")
        firstRepositoryRow.tap()

        // DetailViewの各要素が表示されていることを確認
        XCTAssertTrue(
            app.staticTexts["repositoryName"].exists,
            "Repository name should be displayed in detail view")
        XCTAssertTrue(
            app.staticTexts["repositoryLanguage"].exists, "Repository language should be displayed")
        XCTAssertTrue(
            app.staticTexts["repositoryStars"].exists, "Repository stars should be displayed")
        XCTAssertTrue(
            app.staticTexts["repositoryWatchers"].exists, "Repository watchers should be displayed")
        XCTAssertTrue(
            app.staticTexts["repositoryForks"].exists, "Repository forks should be displayed")
        XCTAssertTrue(
            app.staticTexts["repositoryOpenIssues"].exists,
            "Repository open issues should be displayed")
    }

    func testImageLoadingInDetailView() {
        // テスト用DIContainerの設定
        let testContainer = DIContainer()
        testContainer.register(
            StubRepositoryManager() as RepositoryFetchable, for: RepositoryFetchable.self)
        testContainer.register(StubImageService() as ImageFetchable, for: ImageFetchable.self)

        // アプリの初期化と起動
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        // 検索バーにアクセスし、検索テキストを入力
        let searchBarField = app.otherElements["searchBarField"]
        searchBarField.tap()
        searchBarField.typeText("Swift")
        app.keyboards.buttons["search"].tap()

        // リポジトリ行の選択
        let repositoryList = app.collectionViews["repositoryList"]
        XCTAssertTrue(repositoryList.waitForExistence(timeout: 5))
        let firstRepositoryRow = repositoryList.cells.element(boundBy: 0)
        XCTAssertTrue(firstRepositoryRow.exists, "First repository row should exist")
        firstRepositoryRow.tap()

        // DetailView の画像がロードされるまで待機
        let avatarImage = app.images["avatarImage"]
        let loadingIndicator = app.otherElements["loadingIndicator"]

        if loadingIndicator.exists {
            XCTAssertTrue(
                loadingIndicator.waitForExistence(timeout: 5),
                "Loading indicator should appear while image loads")
        }

        XCTAssertTrue(
            avatarImage.waitForExistence(timeout: 10),
            "Avatar image should be displayed in detail view")
    }

    func testRepositoryRowDisplaysIconsAndLanguage() {
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        let searchBarField = app.otherElements["searchBarField"]
        XCTAssertTrue(searchBarField.waitForExistence(timeout: 5))
        searchBarField.tap()
        searchBarField.typeText("Swift")
        app.keyboards.buttons["search"].tap()

        let firstRepositoryRow = app.collectionViews["repositoryList"].cells.element(boundBy: 0)
        XCTAssertTrue(firstRepositoryRow.exists)

        let repositoryName = firstRepositoryRow.staticTexts["repositoryName_Swift Repo"]
        let repositoryLanguage = firstRepositoryRow.staticTexts["repositoryLanguage_Swift"]
        XCTAssertTrue(repositoryName.exists)
        XCTAssertTrue(repositoryLanguage.exists)
    }
}
