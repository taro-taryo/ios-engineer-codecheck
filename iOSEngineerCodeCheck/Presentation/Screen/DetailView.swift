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
    let repository: RepositoryViewData
    @StateObject private var imageLoader: ImageLoader
    @Environment(\.presentationMode) var presentationMode

    init(repository: RepositoryViewData) {
        self.repository = repository
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString: repository.ownerAvatarURL))
    }

    var body: some View {
        ZStack {
            backgroundGradient
            ScrollView {
                VStack(spacing: 20) {
                    repositoryImage
                    repositoryTitle
                    repositoryDetails
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: { presentationMode.wrappedValue.dismiss() }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text(String(localized: "ui_navigation_back_button"))
                }
                .foregroundColor(.white)
            }
        )
        .modifier(NavigationBarModifier(backgroundColor: .clear))
    }

    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.7)]),
            startPoint: .top, endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var repositoryImage: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.orange, lineWidth: 4))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .frame(width: 160, height: 160)
                    .padding(.top, 100)
            } else {
                ProgressView()
                    .frame(width: 160, height: 160)
                    .padding(.top, 100)
            }
        }
    }

    private var repositoryTitle: some View {
        Text(repository.name)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .padding(.vertical, 10)
    }

    private var repositoryDetails: some View {
        VStack(alignment: .leading, spacing: 15) {
            detailRow(
                title: String(localized: "ui_language_title"), value: repository.language,
                icon: "globe")
            detailRow(
                title: String(localized: "ui_stars_title"), value: "\(repository.stars)",
                icon: "star.fill")
            detailRow(
                title: String(localized: "ui_watchers_title"), value: "\(repository.watchers)",
                icon: "eye.fill")
            detailRow(
                title: String(localized: "ui_forks_title"), value: "\(repository.forks)",
                icon: "tuningfork")
            detailRow(
                title: String(localized: "ui_open_issues_title"), value: "\(repository.openIssues)",
                icon: "exclamationmark.triangle.fill")
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
        .padding(.vertical, 5)
    }

    private func detailRow(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 26, height: 26)
                .background(Color.black.opacity(0.2))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.orange)
                    .fontWeight(.semibold)

                Text(value)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(10)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
