//
//  RepositoryListViewModel.swift
//  iOSEngineerCodeCheck
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

import Combine
import Foundation

class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [RepositoryViewData] = []
    @Published var searchText: String = ""
    @Published var tagSuggestions: [String] = []
    @Published var relatedSuggestions: [String] = []
    @Published var error: AppError?

    private let fetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol
    private let fetchTopicSuggestionsUseCase: FetchTopicSuggestionsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    private let allTags = [
        "swift", "javascript", "python", "java", "ruby", "php", "c++", "c#", "go", "kotlin", "dart",
        "typescript", "html", "css", "shell", "rust", "scala", "julia", "r", "matlab",
    ]

    init(
        fetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol = DIContainer.shared.resolve(
            FetchRepositoriesUseCaseProtocol.self),
        fetchTopicSuggestionsUseCase: FetchTopicSuggestionsUseCaseProtocol = DIContainer.shared
            .resolve(FetchTopicSuggestionsUseCaseProtocol.self)
    ) {
        self.fetchRepositoriesUseCase = fetchRepositoriesUseCase
        self.fetchTopicSuggestionsUseCase = fetchTopicSuggestionsUseCase
        setupSearchTextObserver()
    }

    private func setupSearchTextObserver() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                self.updateTagSuggestions()
                if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.searchRepositories()
                    self.fetchTopicSuggestions(for: text)
                }
            }
            .store(in: &cancellables)
    }

    func updateTagSuggestions() {
        tagSuggestions = allTags.filter { $0.contains(searchText.lowercased()) }
    }

    func searchRepositories() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        fetchRepositoriesUseCase.execute(searchWord: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repositories):
                    self?.repositories = repositories.map { RepositoryViewData(repository: $0) }
                case .failure(let error):
                    if let appError = error as? AppError {
                        self?.error = appError
                    } else {
                        self?.error = AppError.unknown(error.localizedDescription)
                    }
                }
            }
        }
    }

    private func fetchTopicSuggestions(for query: String) {
        fetchTopicSuggestionsUseCase.execute(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let suggestions):
                    self?.relatedSuggestions = suggestions
                case .failure(let error):
                    if let appError = error as? AppError {
                        self?.error = appError
                    } else {
                        self?.error = AppError.unknown(error.localizedDescription)
                    }
                }
            }
        }
    }
}
