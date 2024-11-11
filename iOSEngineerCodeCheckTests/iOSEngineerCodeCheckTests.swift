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
        var repositoryManagerTests = RepositoryManagerTests()
        repositoryManagerTests.setUp()
        repositoryManagerTests.testFetchRepositoriesSuccess()
        repositoryManagerTests.tearDown()

        repositoryManagerTests = RepositoryManagerTests()
        repositoryManagerTests.setUp()
        repositoryManagerTests.testFetchRepositoriesFailure()
        repositoryManagerTests.tearDown()

        repositoryManagerTests = RepositoryManagerTests()
        repositoryManagerTests.setUp()
        repositoryManagerTests.testEmptySearchWordReturnsError()
        repositoryManagerTests.tearDown()

        repositoryManagerTests = RepositoryManagerTests()
        repositoryManagerTests.setUp()
        repositoryManagerTests.testNetworkErrorReturnsAppError()
        repositoryManagerTests.tearDown()

        // RepositoryListViewModelTests
        var repositoryListViewModelTests = RepositoryListViewModelTests()
        repositoryListViewModelTests.setUp()
        repositoryListViewModelTests.testInitialValues()
        repositoryListViewModelTests.tearDown()

        repositoryListViewModelTests = RepositoryListViewModelTests()
        repositoryListViewModelTests.setUp()
        repositoryListViewModelTests.testFetchRepositoriesWithValidSearchText()
        repositoryListViewModelTests.tearDown()

        repositoryListViewModelTests = RepositoryListViewModelTests()
        repositoryListViewModelTests.setUp()
        repositoryListViewModelTests.testFetchRepositoriesWithInvalidSearchText()
        repositoryListViewModelTests.tearDown()

        repositoryListViewModelTests = RepositoryListViewModelTests()
        repositoryListViewModelTests.setUp()
        repositoryListViewModelTests.testSearchRepositoriesUpdatesRepositories()
        repositoryListViewModelTests.tearDown()

        repositoryListViewModelTests = RepositoryListViewModelTests()
        repositoryListViewModelTests.setUp()
        repositoryListViewModelTests.testEmptySearchTextReturnsError()
        repositoryListViewModelTests.tearDown()

        // SearchServiceTests
        var searchServiceTests = SearchServiceTests()
        searchServiceTests.setUp()
        searchServiceTests.testDecodeErrorReturnsAppError()
        searchServiceTests.tearDown()

        searchServiceTests = SearchServiceTests()
        searchServiceTests.setUp()
        searchServiceTests.testFetchRepositoriesSuccess()
        searchServiceTests.tearDown()

        searchServiceTests = SearchServiceTests()
        searchServiceTests.setUp()
        searchServiceTests.testFetchRepositoriesInvalidURL()
        searchServiceTests.tearDown()

        searchServiceTests = SearchServiceTests()
        searchServiceTests.setUp()
        searchServiceTests.testFetchRepositoriesRequestFailed()
        searchServiceTests.tearDown()

        // ImageLoaderTests
        var imageLoaderTests = ImageLoaderTests()
        imageLoaderTests.setUp()
        imageLoaderTests.testInitialImageIsNil()
        imageLoaderTests.tearDown()

        imageLoaderTests = ImageLoaderTests()
        imageLoaderTests.setUp()
        imageLoaderTests.testLoadImageWithValidURL()
        imageLoaderTests.tearDown()

        imageLoaderTests = ImageLoaderTests()
        imageLoaderTests.setUp()
        imageLoaderTests.testLoadImageWithInvalidURL()
        imageLoaderTests.tearDown()

        imageLoaderTests = ImageLoaderTests()
        imageLoaderTests.setUp()
        imageLoaderTests.testLoadImageWithNilURL()
        imageLoaderTests.tearDown()

        // AppErrorTests
        var appErrorTests = AppErrorTests()
        appErrorTests.testNetworkErrorDescription()

        appErrorTests = AppErrorTests()
        appErrorTests.testUnknownErrorDescription()

        // NetworkErrorTests
        var networkErrorTests = NetworkErrorTests()
        networkErrorTests.testInvalidURLErrorDescription()

        networkErrorTests = NetworkErrorTests()
        networkErrorTests.testNoDataErrorDescription()

        networkErrorTests = NetworkErrorTests()
        networkErrorTests.testRequestFailedErrorDescription()
    }
}
