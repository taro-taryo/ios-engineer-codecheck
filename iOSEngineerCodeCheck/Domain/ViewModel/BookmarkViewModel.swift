//
//  BookmarkViewModel.swift
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

import Combine
import Foundation

class BookmarkViewModel: ObservableObject {
    @Published var bookmarks: [RepositoryViewData] = []
    @Published var showUndoToast = false
    private var deletedBookmark: RepositoryViewData?

    private let bookmarkUseCase: BookmarkRepositoryUseCaseProtocol

    init(bookmarkUseCase: BookmarkRepositoryUseCaseProtocol) {
        self.bookmarkUseCase = bookmarkUseCase
        loadBookmarks()
    }

    func loadBookmarks() {
        bookmarks = bookmarkUseCase.fetchBookmarks()
    }

    func toggleBookmark(for repository: RepositoryViewData) {
        if isBookmarked(repository: repository) {
            removeBookmark(repository)
        } else {
            addBookmark(repository)
        }
    }

    func isBookmarked(repository: RepositoryViewData) -> Bool {
        return bookmarkUseCase.isBookmarked(repository: repository)
    }

    private func addBookmark(_ repository: RepositoryViewData) {
        bookmarkUseCase.toggleBookmark(repository: repository)
        loadBookmarks()
    }

    private func removeBookmark(_ repository: RepositoryViewData) {
        deletedBookmark = repository
        bookmarkUseCase.toggleBookmark(repository: repository)
        loadBookmarks()

        // トースト表示をトリガー
        showUndoToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showUndoToast = false
            self.deletedBookmark = nil  // 元に戻さない場合、削除情報をリセット
        }
    }

    func undoDelete() {
        guard let repository = deletedBookmark else { return }
        addBookmark(repository)
        showUndoToast = false
        deletedBookmark = nil
    }
}
