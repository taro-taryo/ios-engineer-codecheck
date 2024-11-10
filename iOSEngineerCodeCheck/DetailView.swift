//
//  DetailView.swift
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

struct DetailView: View {
    let repository: Repository
    @StateObject private var imageLoader = ImageLoader()

    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 16)
            } else {
                ProgressView()
                    .frame(width: 200, height: 200)
                    .padding(.top, 16)
            }
            Text(repository.name)
                .font(.title)
                .padding(.top, 8)
            VStack(alignment: .leading, spacing: 8) {
                Text("Language: \(repository.language)")
                Text("Stars: \(repository.stars)")
                Text("Watchers: \(repository.watchers)")
                Text("Forks: \(repository.forks)")
                Text("Open Issues: \(repository.openIssues)")
            }
            .padding()
            Spacer()
        }
        .onAppear {
            imageLoader.loadImage(from: repository.ownerAvatarURL)
        }
        .navigationTitle("Repository Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
