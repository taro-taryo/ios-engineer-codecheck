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
    var searchWord: String?
    var searchUrl: String?
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTask?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text, !searchWord.isEmpty else {
            print("検索ワードが空またはnilです。")
            return
        }
        searchRepositories(for: searchWord)
    }

    private func searchRepositories(for searchWord: String) {
        searchUrl = "https://api.github.com/search/repositories?q=\(searchWord)"

        guard let urlString = searchUrl, let url = URL(string: urlString) else {
            print("URLの生成に失敗しました。")
            return
        }

        searchTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("ネットワークエラーが発生しました: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("データがnilです。")
                return
            }
            self?.parseData(data)
        }
        searchTask?.resume()
    }

    private func parseData(_ data: Data) {
        do {
            let decodedResponse = try JSONDecoder().decode(RepositoriesResponse.self, from: data)
            self.repositories = decodedResponse.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("データ解析エラー: \(error.localizedDescription)")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Detail",
            let detailViewController = segue.destination as? DetailViewController,
            let selectedIndex = selectedIndex,
            selectedIndex < repositories.count
        else {
            print("詳細画面への遷移に必要なデータが揃っていません。")
            return
        }
        detailViewController.repository = repositories[selectedIndex]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
