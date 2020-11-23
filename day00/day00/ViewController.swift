//
//  ViewController.swift
//  day00
//
//  Created by Dremora Restless on 11/23/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var widthConstraintNulButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        // calculate nul button width
        let miniWidth: CGFloat = ( UIScreen.main.bounds.width - (2 * 12 + 3 * 8) ) / 4.0
        let bigWidth: CGFloat = miniWidth * 2 + 8
        widthConstraintNulButton = widthConstraintNulButton.changeMultiplier(multiplier: bigWidth / miniWidth)
    }

}

extension NSLayoutConstraint {
    func changeMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
    
}
