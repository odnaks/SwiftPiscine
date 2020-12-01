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

    var shape: Shape?
    var color: UIColor?
    
    init(x: CGFloat, y: CGFloat) {
        let shape = Shape.allShapes[Int.random(in: 0..<Shape.allShapes.count)]
        let color = allColors[Int.random(in: 0..<allColors.count)]
        self.shape = shape
        self.color = color
        
        super.init(frame: CGRect(x: x, y: y, width: 100, height: 100))
        if shape == .circle {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 50
        }
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    

}
