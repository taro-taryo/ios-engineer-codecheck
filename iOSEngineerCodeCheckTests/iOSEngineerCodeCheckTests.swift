//
//  iOSEngineerCodeCheckTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

@testable import iOSEngineerCodeCheck

class iOSEngineerCodeCheckTests: XCTestCase {

    let repositoryManagerTests = RepositoryManagerTests()
    let repositoryListViewModelTests = RepositoryListViewModelTests()
    let searchServiceTests = SearchServiceTests()
    let imageLoaderTests = ImageLoaderTests()

    override func setUpWithError() throws {
        // 各テストクラスのセットアップメソッドを呼び出し
        try super.setUpWithError()
        repositoryManagerTests.setUp()
        repositoryListViewModelTests.setUp()
        searchServiceTests.setUp()
        imageLoaderTests.setUp()
    }

    override func tearDownWithError() throws {
        // 各テストクラスのクリーンアップメソッドを呼び出し
        repositoryManagerTests.tearDown()
        repositoryListViewModelTests.tearDown()
        searchServiceTests.tearDown()
        imageLoaderTests.tearDown()
        try super.tearDownWithError()
    }

    func testAll() throws {
        // 各テストクラスのテストメソッドを実行
        repositoryManagerTests.testFetchRepositoriesSuccess()
        repositoryManagerTests.testFetchRepositoriesFailure()
        repositoryListViewModelTests.testFetchRepositoriesWithValidSearchText()
        repositoryListViewModelTests.testFetchRepositoriesWithInvalidSearchText()
        repositoryListViewModelTests.testSearchRepositoriesUpdatesRepositories()
        repositoryListViewModelTests.testEmptySearchTextReturnsError()
        searchServiceTests.testFetchRepositoriesSuccess()
        searchServiceTests.testFetchRepositoriesInvalidURL()
        searchServiceTests.testFetchRepositoriesRequestFailed()
        imageLoaderTests.testLoadImageWithValidURL()
        imageLoaderTests.testLoadImageWithInvalidURL()
        imageLoaderTests.testLoadImageWithNilURL()
    }
}
