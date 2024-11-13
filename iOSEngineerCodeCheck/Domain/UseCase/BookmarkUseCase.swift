//
//  BookmarkUseCase.swift
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

protocol BookmarkUseCaseProtocol {
    func toggleBookmark(for repository: RepositoryViewData)
    func isBookmarked(_ repository: RepositoryViewData) -> Bool
    func fetchBookmarks() -> [RepositoryViewData]
}

class BookmarkUseCase: BookmarkUseCaseProtocol {
    private let repository: BookmarkRepositoryInterface

    init(repository: BookmarkRepositoryInterface) {
        self.repository = repository
    }

    func toggleBookmark(for repository: RepositoryViewData) {
        if isBookmarked(repository) {
            self.repository.removeBookmark(repository)
        } else {
            self.repository.addBookmark(repository)
        }
    }

    func isBookmarked(_ repository: RepositoryViewData) -> Bool {
        // BookmarkRepositoryInterfaceを通じてブックマーク状態を確認
        return self.repository.isBookmarked(repository)
    }

    func fetchBookmarks() -> [RepositoryViewData] {
        return repository.fetchBookmarks()
    }
}
