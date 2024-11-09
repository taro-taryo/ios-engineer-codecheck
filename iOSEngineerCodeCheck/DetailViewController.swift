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

    override func viewDidLoad() {
        super.viewDidLoad()
        displayRepositoryDetails()
        fetchImage()
    }

    private func displayRepositoryDetails() {
        guard let repository = repository else {
            print("リポジトリデータがnilです。")
            return
        }
        languageLabel.text = "Written in \(repository.language)"
        starsLabel.text = "\(repository.stars) stars"
        watchersLabel.text = "\(repository.watchers) watchers"
        forksLabel.text = "\(repository.forks) forks"
        issuesLabel.text = "\(repository.openIssues) open issues"
        titleLabel.text = repository.name
    }

    func fetchImage() {
        guard let imageURLString = repository?.ownerAvatarURL,
            let imageURL = URL(string: imageURLString)
        else {
            print("画像URLがnilまたは不正です。")
            return
        }

        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            if let error = error {
                print("画像のダウンロードエラー: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("画像データがnilまたは変換に失敗しました。")
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
