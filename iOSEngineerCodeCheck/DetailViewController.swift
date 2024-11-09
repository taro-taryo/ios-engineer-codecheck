//
//  ViewController2.swift
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

    var mainViewController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 選択されたリポジトリの詳細を取得して表示する
        let repository = mainViewController.repositories[mainViewController.selectedIndex]

        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        fetchImage()
    }

    func fetchImage() {

        let repository = mainViewController.repositories[mainViewController.selectedIndex]

        titleLabel.text = repository["full_name"] as? String

        // リポジトリ所有者のアバター画像を取得する
        guard let owner = repository["owner"] as? [String: Any],
            let imageURL = owner["avatar_url"] as? String
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
