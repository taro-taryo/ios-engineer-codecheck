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

    var repository: Repository!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 選択されたリポジトリの詳細を取得して表示する
        languageLabel.text = "Written in \(repository.language)"
        starsLabel.text = "\(repository.stars) stars"
        watchersLabel.text = "\(repository.watchers) watchers"
        forksLabel.text = "\(repository.forks) forks"
        issuesLabel.text = "\(repository.openIssues) open issues"
        titleLabel.text = repository.name
        fetchImage()
    }

    func fetchImage() {
        // リポジトリ所有者のアバター画像を取得する
        guard let imageURL = repository.ownerAvatarURL
        else { return }

        // 非同期リクエストで画像をダウンロードして設定
        URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
}
