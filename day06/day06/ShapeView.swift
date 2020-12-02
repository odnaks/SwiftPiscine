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

var allColors: [UIColor] = [.red, .black, .green, .blue]


class ShapeView: UIView {

//    override var collisionBoundingPath: UIBezierPath { return circularPath() }

    var shape: Shape?
    var color: UIColor?
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        guard let shape = self.shape else { return .rectangle }
        return shape == .circle ? .ellipse : .rectangle
    }
    
//    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
//        print("GR - pan")
//        let location = gestureRecognizer.location(in: self)
////        self.frame.origin.x = location.x
////        self.frame.origin.y = location.y
//        self.frame = CGRect(x: location.x, y: location.y, width: self.frame.size.width, height: self.frame.size.height)
//        print(gestureRecognizer)
//        print(location)
////        addShape(location: location)
//    }
    
    init(x: CGFloat, y: CGFloat) {
        let shape = Shape.allShapes[Int.random(in: 0..<Shape.allShapes.count)]
        let color = allColors[Int.random(in: 0..<allColors.count)]
        self.shape = shape
        self.color = color
        
        super.init(frame: CGRect(x: x, y: y, width: 100, height: 100))
        
//        let panPercognizer = UIPanGestureRecognizer()
//        panPercognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
//        self.addGestureRecognizer(panPercognizer)
        
        if shape == .circle {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 50
        }
        
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
