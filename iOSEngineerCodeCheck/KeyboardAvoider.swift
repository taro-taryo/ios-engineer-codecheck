//
//  KeyboardAvoider.swift
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

import Combine
import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillShowNotification
        )
        .merge(
            with: NotificationCenter.default.publisher(
                for: UIResponder.keyboardWillHideNotification)
        )
        .sink { notification in
            if notification.name == UIResponder.keyboardWillShowNotification,
                let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                    as? CGRect
            {
                self.keyboardHeight = keyboardFrame.height
            } else {
                self.keyboardHeight = 0
            }
        }
    }

    deinit {
        cancellable?.cancel()
    }
}

struct KeyboardAvoider: ViewModifier {
    @ObservedObject private var keyboardResponder = KeyboardResponder()

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardResponder.keyboardHeight)
    }
}
