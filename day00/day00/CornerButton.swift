//
//  CornerButton.swift
//  day00
//
//  Created by Dremora Restless on 11/23/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class CornerButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.frame.height / 2.0
    }

}
