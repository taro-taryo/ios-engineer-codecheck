//
//  ServiceLocator.swift
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

import Foundation

class ServiceLocator {
    static func configure(container: DIContainer = DIContainer.shared) {

        // DataSource - Enhanced Search and Bookmark DataSources
        container.register(
            EnhancedSearchRemoteDataSource() as EnhancedSearchRemoteDataSourceProtocol,
            for: EnhancedSearchRemoteDataSourceProtocol.self)
        container.register(
            BookmarkRemoteDataSource() as BookmarkDataSourceProtocol,
            for: BookmarkDataSourceProtocol.self)
        container.register(
            RepositoryRemoteDataSource() as RepositoryRemoteDataSourceProtocol,
            for: RepositoryRemoteDataSourceProtocol.self)

        // Repository - Encapsulating DataSources
        container.register(
            TopicRepository(
                remoteDataSource: container.resolve(EnhancedSearchRemoteDataSourceProtocol.self))
                as TopicRepositoryInterface, for: TopicRepositoryInterface.self)
        container.register(
            BookmarkRepository(remoteDataSource: container.resolve(BookmarkDataSourceProtocol.self))
                as BookmarkRepositoryInterface, for: BookmarkRepositoryInterface.self)
        container.register(
            RepositoryRepository(
                remoteDataSource: container.resolve(RepositoryRemoteDataSourceProtocol.self))
                as RepositoryRepositoryInterface, for: RepositoryRepositoryInterface.self)

        // UseCase - Business Logic Layer
        container.register(
            FetchRepositoriesUseCase(
                repository: container.resolve(RepositoryRepositoryInterface.self))
                as FetchRepositoriesUseCaseProtocol, for: FetchRepositoriesUseCaseProtocol.self)
        container.register(
            FetchTopicSuggestionsUseCase(
                repository: container.resolve(TopicRepositoryInterface.self))
                as FetchTopicSuggestionsUseCaseProtocol,
            for: FetchTopicSuggestionsUseCaseProtocol.self)
        container.register(
            BookmarkUseCase(repository: container.resolve(BookmarkRepositoryInterface.self))
                as BookmarkUseCaseProtocol, for: BookmarkUseCaseProtocol.self)
        container.register(
            FetchImageUseCase(imageFetchable: ImageService()) as FetchImageUseCaseProtocol,
            for: FetchImageUseCaseProtocol.self)

        // ViewModel - Injecting UseCases
        container.register(RepositoryListViewModel(), for: RepositoryListViewModel.self)
        container.register(BookmarkViewModel(), for: BookmarkViewModel.self)
    }
}
