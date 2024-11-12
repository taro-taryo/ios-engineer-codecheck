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
    @StateObject private var bookmarkViewModel = BookmarkViewModel(
        bookmarkUseCase: DIContainer.shared.resolve(BookmarkRepositoryUseCaseProtocol.self))
    @State private var isDrawerOpen = false
    @State private var isBookmarkViewPresented = false
    @FocusState private var isSearchFieldFocused: Bool

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
                    .onTapGesture {
                        isSearchFieldFocused = false
                    }
                mainContent
                drawerMenu
            }
            .navigationBarItems(leading: menuButton)
            .environmentObject(bookmarkViewModel)
            .sheet(isPresented: $isBookmarkViewPresented) {
                BookmarkView()
                    .environmentObject(bookmarkViewModel)
            }
        }
    }

    private var mainContent: some View {
        VStack(spacing: 16) {
            searchBar
            if !viewModel.tagSuggestions.isEmpty || !viewModel.relatedSuggestions.isEmpty {
                suggestionsScrollView
            }
            searchResultsView
        }
        .alert(item: $viewModel.error) { error in
            Alert(
                title: Text(String(localized: "ui_alert_error_title")),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text(String(localized: "ui_alert_ok_button")))
            )
        }
    }

    private var drawerMenu: some View {
        Group {
            if isDrawerOpen {
                DrawerMenu(
                    isDrawerOpen: $isDrawerOpen,
                    isBookmarkViewPresented: $isBookmarkViewPresented
                )
                .environmentObject(bookmarkViewModel)
                .transition(.move(edge: .leading))
            }
        }
    }

    private var menuButton: some View {
        Button(action: {
            withAnimation {
                isDrawerOpen.toggle()
            }
        }) {
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .foregroundColor(.white)
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
            },
            onSearchButtonClicked: {
                viewModel.searchRepositories()
            },
            onCancel: {
                viewModel.onSearchCancelled()
            }
        )
        .focused($isSearchFieldFocused)
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var suggestionsScrollView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !viewModel.tagSuggestions.isEmpty {
                Text(String(localized: "ui_tag_suggestions_title"))
                    .font(.subheadline)
                    .foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.tagSuggestions, id: \.self) { suggestion in
                            Button(action: {
                                viewModel.onTagSuggestionSelected(suggestion)
                                isSearchFieldFocused = false
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

            if !viewModel.relatedSuggestions.isEmpty {
                Text(String(localized: "ui_related_topics_title"))
                    .font(.subheadline)
                    .foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.relatedSuggestions, id: \.self) { suggestion in
                            Button(action: {
                                viewModel.onTagSuggestionSelected(suggestion)
                                isSearchFieldFocused = false
                            }) {
                                Text(suggestion)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.green)
                                    .cornerRadius(15)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 8)
    }

    private var searchResultsView: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "ui_search_results_title"))
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)

            if viewModel.repositories.isEmpty {
                Text(String(localized: "ui_no_repositories_found"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .transition(.opacity)
            } else {
                List(viewModel.repositories) { repository in
                    RepositoryRow(repository: repository)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 5)
                        .onTapGesture {
                            isSearchFieldFocused = false
                        }
                }
                .listStyle(PlainListStyle())
                .transition(.slide)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
