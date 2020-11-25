//
//  NoteCell.swift
//  day02
//
//  Created by Dremora Restless on 11/25/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height - 20))
        let image = UIImage(named: "paperBackground")
        imageView.image = image
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        self.backgroundView = UIView()
        self.backgroundView!.addSubview(imageView)
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
