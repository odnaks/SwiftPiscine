//
//  PlaceCell.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 30.11.2020.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
