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
    private let searchService = SearchService()
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text, !searchWord.isEmpty else {
            print("検索ワードが空またはnilです。")
            return
        }
        searchRepositories(for: searchWord)
    }

    private func searchRepositories(for searchWord: String) {
        searchService.searchRepositories(for: searchWord) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("データ取得エラー: \(error.localizedDescription)")
            }
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

    private func configureCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "RepositoryCell")
        configureCell(cell, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
