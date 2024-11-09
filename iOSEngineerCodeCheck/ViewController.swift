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
        guard let searchWord = searchBar.text, !searchWord.isEmpty else { return }
        searchRepositories(for: searchWord)
    }

    private func searchRepositories(for searchWord: String) {
        searchUrl = "https://api.github.com/search/repositories?q=\(searchWord)"

        guard let url = URL(string: searchUrl ?? "") else { return }

        searchTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            self?.parseData(data)
        }
        searchTask?.resume()
    }

    private func parseData(_ data: Data) {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let items = jsonObject["items"] as? [[String: Any]]
            {
                self.repositories = items.map { Repository(from: $0) }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            print("データ解析エラー: \(error.localizedDescription)")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Detail",
            let detailViewController = segue.destination as? DetailViewController,
            let selectedIndex = selectedIndex
        else { return }
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
