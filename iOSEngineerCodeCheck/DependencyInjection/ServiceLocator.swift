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
        container.register(
            FetchRepositoriesUseCase(repositoryFetchable: RepositoryDataSource())
                as FetchRepositoriesUseCaseProtocol, for: FetchRepositoriesUseCaseProtocol.self)
        container.register(
            FetchImageUseCase(imageFetchable: ImageService()) as FetchImageUseCaseProtocol,
            for: FetchImageUseCaseProtocol.self)

        // RepositoryListViewModel の登録
        container.register(
            RepositoryListViewModel(
                fetchRepositoriesUseCase: container.resolve(FetchRepositoriesUseCaseProtocol.self)),
            for: RepositoryListViewModel.self
        )
    }
}
