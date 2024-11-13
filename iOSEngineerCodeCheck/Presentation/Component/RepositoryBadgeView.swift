//
//  RepositoryBadgeView.swift
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

struct RepositoryBadgeView: View {
    let stars: Int
    let forks: Int

    var body: some View {
        HStack(spacing: 8) {
            Badge(
                iconName: "star.fill", count: stars, color: Color.yellow.opacity(0.15),
                textColor: .yellow
            )
            .accessibilityIdentifier("starBadge")
            Badge(
                iconName: "tuningfork", count: forks, color: Color.blue.opacity(0.15),
                textColor: .blue
            )
            .accessibilityIdentifier("forkBadge")
        }
    }

    private struct Badge: View {
        let iconName: String
        let count: Int
        let color: Color
        let textColor: Color

        var body: some View {
            HStack(spacing: 4) {
                Image(systemName: iconName)
                    .foregroundColor(textColor)
                Text("\(count)")
                    .foregroundColor(textColor)
                    .bold()
            }
            .padding(8)
            .background(Capsule().fill(color))
            .overlay(Capsule().stroke(textColor.opacity(0.3), lineWidth: 1))
        }
    }
}
