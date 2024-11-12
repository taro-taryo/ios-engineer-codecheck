//
//  RepositoryViewData.swift
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

import Foundation

struct RepositoryViewData: Identifiable {
    let id: UUID
    let name: String
    let language: String
    let stars: Int
    let watchers: Int
    let forks: Int
    let openIssues: Int
    let ownerAvatarURL: String?

    init(repository: Repository) {
        self.id = repository.id
        self.name = repository.name
        self.language = repository.language
        self.stars = repository.stars
        self.watchers = repository.watchers
        self.forks = repository.forks
        self.openIssues = repository.openIssues
        self.ownerAvatarURL = repository.ownerAvatarURL
    }
}
