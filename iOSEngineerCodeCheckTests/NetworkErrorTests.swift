//
//  NetworkErrorTests.swift
//  iOSEngineerCodeCheck
//
//  Created by taro-taryo on 2024/11/11.
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

class NetworkErrorTests: XCTestCase {
    func testInvalidURLErrorDescription() {
        let error = NetworkError.invalidURL
        XCTAssertEqual(error.localizedDescription, "The URL provided was invalid.")
    }

    func testNoDataErrorDescription() {
        let error = NetworkError.noData
        XCTAssertEqual(error.localizedDescription, "No data was received from the server.")
    }

    func testRequestFailedErrorDescription() {
        let error = NetworkError.requestFailed(
            NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        )
        XCTAssertEqual(error.localizedDescription, "Request failed with error: Network error")
    }
}
