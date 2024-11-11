//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by taro-taryo on 2024/11/09.
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

struct RepositoriesResponse: Codable {
    let items: [Repository]
}

// GitHubリポジトリ情報を管理するデータモデル
struct Repository: Codable, Identifiable {
    let id = UUID()
    let name: String
    let language: String
    let stars: Int
    let watchers: Int
    let forks: Int
    let openIssues: Int
    let ownerAvatarURL: String?

    // カスタムデコーダーのイニシャライザ
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? "N/A"
        self.stars = try container.decodeIfPresent(Int.self, forKey: .stars) ?? 0
        self.watchers = try container.decodeIfPresent(Int.self, forKey: .watchers) ?? 0
        self.forks = try container.decodeIfPresent(Int.self, forKey: .forks) ?? 0
        self.openIssues = try container.decodeIfPresent(Int.self, forKey: .openIssues) ?? 0

        if let ownerContainer = try? container.nestedContainer(
            keyedBy: OwnerKeys.self, forKey: .owner)
        {
            self.ownerAvatarURL = try ownerContainer.decodeIfPresent(
                String.self, forKey: .avatarURL)
        } else {
            self.ownerAvatarURL = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(language, forKey: .language)
        try container.encode(stars, forKey: .stars)
        try container.encode(watchers, forKey: .watchers)
        try container.encode(forks, forKey: .forks)
        try container.encode(openIssues, forKey: .openIssues)

        if let ownerAvatarURL = ownerAvatarURL {
            var ownerContainer = container.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
            try ownerContainer.encode(ownerAvatarURL, forKey: .avatarURL)
        }
    }

    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case language
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case forks = "forks_count"
        case openIssues = "open_issues_count"
        case owner
    }

    enum OwnerKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
