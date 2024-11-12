//
//  BookmarkView.swift
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

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var viewModel: BookmarkViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.bookmarks.isEmpty {
                    Text("No bookmarks available.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.bookmarks) { repository in
                        HStack {
                            NavigationLink(destination: DetailView(repository: repository)) {
                                RepositoryRow(repository: repository)
                            }
                            Button(action: {
                                viewModel.toggleBookmark(for: repository)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Bookmarks")
            .overlay(undoToastView, alignment: .bottom)
        }
    }

    private var undoToastView: some View {
        Group {
            if viewModel.showUndoToast {
                VStack {
                    Spacer()
                    HStack {
                        Text("ui_delete_book_mark_toast")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 16)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        viewModel.undoDelete()
                    }
                }
                .padding(.bottom, 20)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
            }
        }
    }
}
