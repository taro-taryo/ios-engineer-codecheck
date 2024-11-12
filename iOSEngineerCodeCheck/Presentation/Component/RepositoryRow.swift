//
//  RepositoryRow.swift
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

struct RepositoryRow: View {
    let repository: RepositoryViewData

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                HStack {
                    if let icon = LanguageIconProvider.icon(for: repository.language) {
                        icon
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                    }
                    Text(repository.language)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                RepositoryBadgeView(stars: repository.stars, forks: repository.forks)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Label("\(repository.watchers)", systemImage: "eye.fill")
                    .foregroundColor(.secondary)
                Label("\(repository.openIssues)", systemImage: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
