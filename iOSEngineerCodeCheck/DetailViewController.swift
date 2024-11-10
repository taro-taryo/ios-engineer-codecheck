//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var repository: Repository?
    private let imageService: ImageFetchable

    init(imageService: ImageFetchable = ImageService()) {
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.imageService = ImageService()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayRepositoryDetails()
        fetchRepositoryImage()
    }

    private func displayRepositoryDetails() {
        guard let repository = repository else {
            showError(message: "リポジトリの詳細情報を表示できません。")
            return
        }
        languageLabel.text = "Written in \(repository.language)"
        starsLabel.text = "\(repository.stars) stars"
        watchersLabel.text = "\(repository.watchers) watchers"
        forksLabel.text = "\(repository.forks) forks"
        issuesLabel.text = "\(repository.openIssues) open issues"
        titleLabel.text = repository.name
    }

    private func fetchRepositoryImage() {
        guard let imageURLString = repository?.ownerAvatarURL else {
            showError(message: "画像URLが無効です。")
            return
        }

        imageService.fetchImage(from: imageURLString) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
