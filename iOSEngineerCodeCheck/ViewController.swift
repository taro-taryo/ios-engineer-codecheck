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
    private let repositoryManager: RepositoryFetchable
    var selectedIndex: Int?

    init(repositoryManager: RepositoryFetchable = RepositoryManager()) {
        self.repositoryManager = repositoryManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.repositoryManager = RepositoryManager()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar.placeholder = "GitHubリポジトリを検索"
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text, !searchWord.isEmpty else {
            showError(message: "検索ワードを入力してください。")
            return
        }
        performRepositorySearch(for: searchWord)
    }

    private func performRepositorySearch(for searchWord: String) {
        repositoryManager.fetchRepositories(for: searchWord) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.updateRepositories(with: repositories)
            case .failure:
                self?.showError(message: "リポジトリの検索に失敗しました。再試行してください。")
            }
        }
    }

    private func updateRepositories(with repositories: [Repository]) {
        self.repositories = repositories
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Detail",
            let detailViewController = segue.destination as? DetailViewController,
            let selectedIndex = selectedIndex,
            selectedIndex < repositories.count
        else {
            showError(message: "詳細画面への遷移に失敗しました。データが不足しています。")
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
