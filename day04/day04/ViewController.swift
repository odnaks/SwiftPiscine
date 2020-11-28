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
    //    private let OAUTH_CONSUMER_KEY = ""
//    private let OAUTH_TOKEN = ""
    private let cellIdentifier = "TweetTableViewCell"

    private var tweets = [Tweet]()
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        APIController.getToken{ token in
            let api = APIController(withToken: token, andDelegate: self)
            api.search(by: "trump")
        }
//        api.search(with: "ecole 42")
        
        
        //api.gettoken
        //api.search(token)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TweetTableViewCell else { return UITableViewCell() }
        cell.tweetNameLabel.text = tweets[indexPath.row].name
        cell.tweetDateLabel.text = dateToString(date: tweets[indexPath.row].date)
        cell.tweetTextLabel.text = tweets[indexPath.row].text
        return cell
    }
    
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD.MM.YYYY hh:mm"
        return dateFormatter.string(from: date)
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
        //
    }
    
    
}
