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
    @StateObject private var viewModel = RepositoryListViewModel()
    @State private var keyboardVisible: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if keyboardVisible {
                    Spacer()
                }
                SearchBar(
                    text: $viewModel.searchText,
                    onSearchButtonClicked: {
                        viewModel.searchRepositories()
                    })
                List(viewModel.repositories) { repository in
                    NavigationLink(destination: DetailView(repository: repository)) {
                        RepositoryRow(repository: repository)
                    }
                }
                .frame(maxHeight: keyboardVisible ? .infinity : .none)
            }
            .navigationTitle("Repositories")
            .alert(item: $viewModel.error) { error in
                Alert(
                    title: Text("Error"), message: Text(error.message),
                    dismissButton: .default(Text("OK")))
            }
            .onAppear {
                // キーボード表示を監視
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main
                ) { _ in
                    withAnimation {
                        self.keyboardVisible = true
                    }
                }
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main
                ) { _ in
                    withAnimation {
                        self.keyboardVisible = false
                    }
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(
                    self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(
                    self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearchButtonClicked: () -> Void

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "GitHubリポジトリを検索"
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: SearchBar

        init(_ parent: SearchBar) {
            self.parent = parent
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            parent.text = searchBar.text ?? ""
            parent.onSearchButtonClicked()
            searchBar.resignFirstResponder()
        }
    }
}

#Preview {
    ContentView()
}
