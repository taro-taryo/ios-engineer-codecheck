//
//  ContentView.swift
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

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: RepositoryListViewModel
    @State private var isIncrementalSearchMode = false

    init(
        viewModel: RepositoryListViewModel = DIContainer.shared.resolve(
            RepositoryListViewModel.self)
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                VStack(spacing: 16) {
                    searchBar
                    if isIncrementalSearchMode && !viewModel.tagSuggestions.isEmpty {
                        tagSuggestionsScrollView
                    }
                    searchResultsView
                }
                .alert(item: $viewModel.error) { error in
                    Alert(
                        title: Text("Error"),
                        message: Text(error.localizedDescription),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var searchBar: some View {
        SearchBar(
            text: $viewModel.searchText,
            onTextChanged: { newText in
                viewModel.onSearchTextChanged(newText)
                isIncrementalSearchMode = !newText.isEmpty
            },
            onSearchButtonClicked: {
                viewModel.searchRepositories()
            },
            onCancel: {
                viewModel.onSearchCancelled()
                isIncrementalSearchMode = false
            }
        )
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var tagSuggestionsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.tagSuggestions, id: \.self) { suggestion in
                    Button(action: {
                        viewModel.onTagSuggestionSelected(suggestion)
                        isIncrementalSearchMode = false
                    }) {
                        Text(suggestion)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private var searchResultsView: some View {
        VStack(alignment: .leading) {
            Text("Search Results")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)
            if viewModel.repositories.isEmpty {
                Text("No repositories found")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .transition(.opacity)
            } else {
                List(viewModel.repositories) { repository in
                    NavigationLink(destination: DetailView(repository: repository)) {
                        RepositoryRow(repository: repository)
                    }
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
                .transition(.slide)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
