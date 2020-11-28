//
//  TweetTableViewCell.swift
//  day04
//
//  Created by Kseniya Lukoshkina on 28.11.2020.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel! {
        didSet {
            tweetTextLabel.numberOfLines = 0
            tweetTextLabel.lineBreakMode = .byWordWrapping
        }
    }
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        tweetNameLabel.text = tweet?.name
        tweetDateLabel.text = dateToString(date: tweet?.date ?? Date())
        tweetTextLabel.text = tweet?.text
    }
    
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY hh:mm"
        return dateFormatter.string(from: date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
