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
    
    func testAll() throws {
        // RepositoryManagerTests
        let repositoryManagerTests = RepositoryManagerTests()
        repositoryManagerTests.setUp()
        repositoryManagerTests.testFetchRepositoriesSuccess()
        repositoryManagerTests.testFetchRepositoriesFailure()
        repositoryManagerTests.testEmptySearchWordReturnsError()
        repositoryManagerTests.tearDown()

        // RepositoryListViewModelTests
        let repositoryListViewModelTests = RepositoryListViewModelTests()
        repositoryListViewModelTests.setUp()
        repositoryListViewModelTests.testFetchRepositoriesWithValidSearchText()
        repositoryListViewModelTests.testFetchRepositoriesWithInvalidSearchText()
        repositoryListViewModelTests.testSearchRepositoriesUpdatesRepositories()
        repositoryListViewModelTests.testEmptySearchTextReturnsError()
        repositoryListViewModelTests.tearDown()

        // SearchServiceTests
        let searchServiceTests = SearchServiceTests()
        searchServiceTests.setUp()
        searchServiceTests.testFetchRepositoriesSuccess()
        searchServiceTests.testFetchRepositoriesInvalidURL()
        searchServiceTests.testFetchRepositoriesRequestFailed()
        searchServiceTests.tearDown()

        // ImageLoaderTests
        let imageLoaderTests = ImageLoaderTests()
        imageLoaderTests.setUp()
        imageLoaderTests.testLoadImageWithValidURL()
        imageLoaderTests.testLoadImageWithInvalidURL()
        imageLoaderTests.testLoadImageWithNilURL()
        imageLoaderTests.tearDown()

        // AppErrorTests
        let appErrorTests = AppErrorTests()
        appErrorTests.testNetworkErrorDescription()
        appErrorTests.testUnknownErrorDescription()

        // NetworkErrorTests
        let networkErrorTests = NetworkErrorTests()
        networkErrorTests.testInvalidURLErrorDescription()
        networkErrorTests.testNoDataErrorDescription()
        networkErrorTests.testRequestFailedErrorDescription()
    }
}
