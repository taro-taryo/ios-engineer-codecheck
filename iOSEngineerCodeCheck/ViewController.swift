//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//
import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    var repositories: [Repository] = []

    var searchTask: URLSessionTask?
    var searchWord: String!
    var searchUrl: String!
    var selectedIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期設定：検索バーのテキストとデリゲートの設定
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 編集開始時にテキストをクリアする
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 検索テキストが変更されたら、進行中の検索タスクをキャンセルする
        searchTask?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchWord = searchBar.text!

        // 検索ワードが空でない場合のみ実行
        guard searchWord.count != 0 else { return }

        // GitHub APIの検索URLを生成
        searchUrl = "https://api.github.com/search/repositories?q=\(searchWord!)"

        // 非同期でAPIリクエストを実行
        searchTask = URLSession.shared.dataTask(with: URL(string: searchUrl)!) {
            (data, response, error) in
            guard let data = data else { return }
            self.parseData(data)
        }

        // リストを更新するためにタスクを開始
        searchTask?.resume()
    }

    private func parseData(_ data: Data) {
        // 取得したデータをJSONとして解析し、リポジトリ情報を保存
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let items = jsonObject["items"] as? [[String: Any]]
        {
            self.repositories = items.map { Repository(from: $0) }
            // メインスレッドでテーブルビューを更新
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 詳細画面に遷移する際にデータを渡す
        guard segue.identifier == "Detail",
            let detailViewController = segue.destination as? DetailViewController
        else { return }

        detailViewController.repository = repositories[selectedIndex]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // テーブルの行数をリポジトリの数に設定
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // リストアイテムが選択されたときに画面遷移を実行
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
