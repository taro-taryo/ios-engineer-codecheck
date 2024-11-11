//
//  ImageLoaderTests.swift
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

import UIKit
import XCTest

@testable import iOSEngineerCodeCheck

class ImageLoaderTests: XCTestCase {

    var imageLoader: ImageLoader!
    var stubImageService: StubImageService!

    override func setUp() {
        super.setUp()
        stubImageService = StubImageService()
        imageLoader = ImageLoader(imageService: stubImageService)
    }

    override func tearDown() {
        imageLoader = nil
        stubImageService = nil
        super.tearDown()
    }

    func testLoadImageWithValidURL() {
        let expectation = XCTestExpectation(description: "Image loaded successfully")

        stubImageService.image = UIImage()
        imageLoader.loadImage(from: "validURL")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.imageLoader.image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadImageWithInvalidURL() {
        let expectation = XCTestExpectation(description: "Image loading failed with nil")
        stubImageService.shouldReturnError = true  // エラーを強制してnilを返すように設定

        imageLoader.loadImage(from: "invalidURL")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(self.imageLoader.image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadImageWithNilURL() {
        let expectation = XCTestExpectation(description: "No image loaded when URL is nil")

        imageLoader.loadImage(from: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(self.imageLoader.image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
