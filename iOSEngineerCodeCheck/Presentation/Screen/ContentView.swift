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
    @StateObject private var viewModel = DIContainer.shared.resolve(RepositoryListViewModel.self)
    @StateObject private var bookmarkViewModel = DIContainer.shared.resolve(BookmarkViewModel.self)
    @State private var isBookmarkViewPresented = false
    @FocusState private var isSearchFieldFocused: Bool
    @State private var isDetailViewPresented = false
    @State private var selectedRepository: RepositoryViewData?

    var body: some View {
        ZStack {
            backgroundGradient
                .onTapGesture { isSearchFieldFocused = false }
            
            mainContent
                .padding(.top, 20)
                .onAppear { activateInitialFocus() }
                .alert(item: $viewModel.error, content: showAlert)
                .sheet(isPresented: $isDetailViewPresented, onDismiss: dismissDetailView) {
                    if let repository = selectedRepository {
                        DetailView(repository: repository)
                    }
                }
        }
        .sheet(isPresented: $isBookmarkViewPresented) {
            BookmarkView().environmentObject(bookmarkViewModel)
        }
        .environmentObject(bookmarkViewModel)
    }
    
    // MARK: Main Content for body
    private var mainContent: some View {
        VStack(spacing: 16) {
            searchBarWithBookmarkButton
            if !viewModel.tagSuggestions.isEmpty || !viewModel.relatedSuggestions.isEmpty {
                suggestionsScrollView
            }
            
            if viewModel.repositories.isEmpty {
                placeholderText
            } else {
                searchResultsView
            }
        }
    }

    private var searchBarWithBookmarkButton: some View {
        HStack {
            searchBar
            bookmarkButton
        }
        .padding(.horizontal)
    }
    
    // MARK: UI Components -
    private var searchBar: some View {
        SearchBar(
            text: $viewModel.searchText,
            onTextChanged: handleTextChanged,
            onSearchButtonClicked: executeSearch,
            onCancel: resetSearch
        )
        .focused($isSearchFieldFocused)
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var bookmarkButton: some View {
        Button(action: toggleBookmarkView) {
            Image(systemName: "bookmark")
                .imageScale(.large)
                .foregroundColor(.blue)
        }
        .padding(.leading, 8)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var placeholderText: some View {
        Text(String(localized: "ui_search_placeholder"))
            .foregroundColor(.gray)
            .font(.headline)
            .padding()
    }
    
    private var suggestionsScrollView: some View {
        VStack(alignment: .leading, spacing: 8) {
            suggestionSection(title: String(localized: "ui_search_tag_suggestions"), suggestions: viewModel.tagSuggestions, backgroundColor: .blue)
            suggestionSection(title: String(localized: "ui_search_related_suggestions"), suggestions: viewModel.relatedSuggestions, backgroundColor: .green)
        }
        .padding(.top, 8)
    }

    private func suggestionSection(title: String, suggestions: [String], backgroundColor: Color) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        SuggestionButton(text: suggestion, backgroundColor: backgroundColor, action: {
                            viewModel.searchText = suggestion
                            isSearchFieldFocused = false
                            viewModel.searchRepositories()
                        })
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var searchResultsView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.repositories) { repository in
                    RepositoryRow(repository: repository)
                        .environmentObject(bookmarkViewModel)
                        .padding(.vertical, 5)
                        .frame(maxWidth: 600)
                        .onTapGesture { presentDetailView(for: repository) }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Handlers -
    
    private func handleTextChanged(newText: String) {
        viewModel.searchText = newText
        viewModel.updateTagSuggestions()
    }

    private func executeSearch() {
        viewModel.searchRepositories()
        isSearchFieldFocused = false
    }

    private func resetSearch() {
        viewModel.searchText = ""
        isSearchFieldFocused = false
    }

    private func activateInitialFocus() {
        isSearchFieldFocused = true
    }
    
    private func presentDetailView(for repository: RepositoryViewData) {
        isSearchFieldFocused = false
        selectedRepository = repository
        isDetailViewPresented = true
    }

    private func toggleBookmarkView() {
        isBookmarkViewPresented.toggle()
    }

    private func showAlert(for error: AppError) -> Alert {
        Alert(title: Text(String(localized: "ui_alert_error_title")), message: Text(error.localizedDescription), dismissButton: .default(Text(String(localized: "ui_alert_ok_button"))))
    }

    private func dismissDetailView() {
        isSearchFieldFocused = false
    }
}
