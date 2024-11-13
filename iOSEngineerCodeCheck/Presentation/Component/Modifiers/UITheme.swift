//
//  UITheme.swift
//  iOSEngineerCodeCheck
//
//  Created by taro-taryo on 2024/11/11.
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

struct UITheme {
    static let primaryColor = Color.blue.opacity(0.9)
    static let accentColor = Color.orange.opacity(0.8)
    static let backgroundColor = Color(UIColor.systemGray6)
    static let cardShadowColor = Color.black.opacity(0.15)
    static let textColor = Color.primary
    static let font = Font.system(size: 16, weight: .semibold, design: .rounded)

    static var gradientBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static func applyCardStyle() -> some ViewModifier { return CardStyle() }
    static func animatedButtonStyle() -> some ViewModifier { return AnimatedButtonStyle() }

    private struct CardStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .background(UITheme.backgroundColor)
                .cornerRadius(12)
                .shadow(color: UITheme.cardShadowColor, radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                .padding(.vertical, 4)
        }
    }

    private struct AnimatedButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(.white)
                .padding()
                .background(UITheme.primaryColor)
                .clipShape(Capsule())
                .shadow(color: UITheme.cardShadowColor, radius: 4)
                .scaleEffect(1.05)
                .animation(.easeInOut(duration: 0.2), value: true)
        }
    }
}
