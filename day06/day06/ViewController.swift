//
//  ViewController.swift
//  day06
//
//  Created by Kseniya Lukoshkina on 01.12.2020.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior()
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleLongPressGesture(_:)))
        view.addGestureRecognizer(recognizer)
        
        
    }
    
    @objc func handleLongPressGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: self.view)
        addShape(location: location)
//        self.view.addSubview(ShapeView(x: location.x, y: location.y))
        
        print("gesture")
    }
    
    private func addShape(location: CGPoint) {
//        guard let x = location.x as? Int, let y = location.y as? Int else { return }
//        view.addSubview(ShapeView(x: location.x, y: location.y))
//        DispatchQueue.main.async {
//            var animator = UIDynamicAnimator(referenceView: self.view)
//            let shape = ShapeView(x: location.x, y: location.y)
//            self.view.addSubview(shape)
//            var gravity = UIGravityBehavior(items: [shape])
//            gravity.magnitude = .greatestFiniteMagnitude
//            animator.addBehavior(gravity)
//        }
        let square = ShapeView(x: location.x, y: location.y)
        view.addSubview(square)
        
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        
        collision.addItem(square)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }


}

