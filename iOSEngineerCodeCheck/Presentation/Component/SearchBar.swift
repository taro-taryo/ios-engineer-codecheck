//
//  SearchBar.swift
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

struct SearchBar: View {
    @Binding var text: String
    var onTextChanged: (String) -> Void
    var onSearchButtonClicked: () -> Void
    var onCancel: () -> Void
    @State private var isEditing = false

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(isEditing ? .white : .gray)
                .padding(.leading, 10)

            TextField(
                String(localized: "ui_search_placeholder"),
                text: $text
            )
            .onChange(of: text) { newText in
                onTextChanged(newText)
            }
            .padding(10)
            .foregroundColor(.white)
            .background(isEditing ? Color.blue.opacity(0.9) : Color.gray.opacity(0.5))
            .cornerRadius(15)
            .transition(.move(edge: .leading))

            if isEditing {
                Button(action: {
                    text = ""
                    onCancel()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                }
                .transition(.scale)
            }
        }
        .padding(.horizontal, isEditing ? 16 : 10)
        .padding(.vertical, 8)
        .background(Color.black.opacity(isEditing ? 0.8 : 0.5))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
        .onTapGesture {
            withAnimation {
                isEditing = true
            }
        }
    }
}
