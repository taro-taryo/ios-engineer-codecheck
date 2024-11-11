//
//  Repository+Stub.swift
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

import Foundation

@testable import iOSEngineerCodeCheck

extension Repository {
    static func stub(
        name: String = "Sample Repo",
        language: String = "Swift",
        stars: Int = 100,
        watchers: Int = 50,
        forks: Int = 10,
        openIssues: Int = 5,
        ownerAvatarURL: String? = "https://example.com/avatar.png"
    ) -> Repository {
        let jsonData = """
            {
                "full_name": "\(name)",
                "language": "\(language)",
                "stargazers_count": \(stars),
                "watchers_count": \(watchers),
                "forks_count": \(forks),
                "open_issues_count": \(openIssues),
                "owner": {
                    "avatar_url": "\(ownerAvatarURL ?? "")"
                }
            }
            """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Repository.self, from: jsonData)
        } catch {
            fatalError("Failed to decode Repository stub: \(error)")
        }
    }
}
