//
//  CornerView.swift
//  day00
//
//  Created by Dremora Restless on 11/23/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class CornerButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        self.layer.cornerRadius = self.layer.frame.width / 2.0
    }

}
