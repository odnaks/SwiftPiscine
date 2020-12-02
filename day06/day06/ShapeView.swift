//
//  ShapeView.swift
//  day06
//
//  Created by Kseniya Lukoshkina on 01.12.2020.
//

import UIKit

enum Shape {
    case circle
    case square
    
    static var allShapes: [Shape] = [circle, square]
}

var allColors: [UIColor] = [UIColor(red: 0.24, green: 0.33, blue: 0.21, alpha: 1.00),
                            UIColor(red: 0.58, green: 0.56, blue: 0.28, alpha: 1.00),
                            UIColor(red: 0.96, green: 0.85, blue: 0.45, alpha: 1.00),
                            UIColor(red: 0.96, green: 0.96, blue: 0.94, alpha: 1.00),
                            UIColor(red: 0.90, green: 0.36, blue: 0.49, alpha: 1.00)]

class ShapeView: UIView {

//    override var collisionBoundingPath: UIBezierPath { return circularPath() }

    var shape: Shape?
    var color: UIColor?
    var savedSize: CGSize?
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        guard let shape = self.shape else { return .rectangle }
        return shape == .circle ? .ellipse : .rectangle
    }
    
    init(x: CGFloat, y: CGFloat) {
        let shape = Shape.allShapes[Int.random(in: 0..<Shape.allShapes.count)]
        let color = allColors[Int.random(in: 0..<allColors.count)]
        self.shape = shape
        self.color = color
        self.savedSize = CGSize(width: 100, height: 100)
        
        super.init(frame: CGRect(x: x, y: y, width: 100, height: 100))
        
        if shape == .circle { setCorner() }
        
        self.backgroundColor = color
    }
    
    func setCorner() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
