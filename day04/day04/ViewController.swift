//
//  ViewController.swift
//  day04
//
//  Created by Dremora Restless on 11/27/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let cellIdentifier = "TweetTableViewCell"

    @IBOutlet weak var searchBar: UISearchBar!
    private var tweets = [Tweet]()
    private var token: String?
    private var api: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "enter a keyword..."
        
        APIController.getToken{ (token, error) in
            if let token = token {
                self.api = APIController(withToken: token, andDelegate: self)
                self.api?.search(by: "Ecole 42")
            } else if let error = error {
                self.showAlert(withError: error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TweetTableViewCell else { return UITableViewCell() }
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension ViewController: APITwitterDelegate {
    func manageReceived(_ tweets: [Tweet]) {
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert(withError error: Error) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alertVC, animated: false)
        }
    }

    
}

extension ViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let api = self.api else { return }
        api.search(by: searchBar.text ?? "")
    }
}
