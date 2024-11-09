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

    var repositories: [[String: Any]] = []

    var searchTask: URLSessionTask?
    var searchWord: String!
    var searchUrl: String!
    var selectedIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTask?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchWord = searchBar.text!

        guard searchWord.count != 0 else { return }

        searchUrl = "https://api.github.com/search/repositories?q=\(searchWord!)"

        searchTask = URLSession.shared.dataTask(with: URL(string: searchUrl)!) {
            (data, response, error) in
            guard let data = data else { return }
            self.parseData(data)
        }

        // これ呼ばなきゃリストが更新されません
        searchTask?.resume()
    }

    private func parseData(_ data: Data) {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let items = jsonObject["items"] as? [[String: Any]]
        {
            self.repositories = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "Detail",
            let detailViewController = segue.destination as? DetailViewController
        else { return }

        detailViewController.mainViewController = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
