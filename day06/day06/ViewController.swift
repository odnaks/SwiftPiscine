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
    var dynamicItem: UIDynamicItemBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicItem = UIDynamicItemBehavior()
        dynamicItem.elasticity = 0.5
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(dynamicItem)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(handleTapGesture(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        print("GR - tap")
        let location = gestureRecognizer.location(in: self.view)
        addShape(location: location)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("GR - pan")
//        gestureRecognizer.view?.frame = CGRect(x: gestureRecognizer.location(in: self.view).x, y: gestureRecognizer.location(in: self.view).y, width: gestureRecognizer.view?.frame.size.width ?? 0, height: gestureRecognizer.view?.frame.size.height ?? 0)
        guard let shapeView = gestureRecognizer.view as? ShapeView else { return }
        switch gestureRecognizer.state {
            case .began:
                gravity.removeItem(shapeView)
            case .changed:
                collision.removeItem(shapeView)
                dynamicItem.removeItem(shapeView)
//                shapeView.center = gestureRecognizer.location(in: self.view)
                shapeView.center.x += gestureRecognizer.translation(in: self.view).x
                shapeView.center.y += gestureRecognizer.translation(in: self.view).y
                collision.addItem(shapeView)
                dynamicItem.addItem(shapeView)
                animator.updateItem(usingCurrentState: shapeView)
                gestureRecognizer.setTranslation(.zero, in: view)
            case .ended, .cancelled, .failed:
                gravity.addItem(shapeView)
            default:
                break
        }
    }
//    @objc func handlePanGesture(_ gestureRecognizer: UITapGestureRecognizer) {
//        print("GR - pan")
//        let location = gestureRecognizer.location(in: self.view)
//        addShape(location: location)
//    }
    
    private func addShape(location: CGPoint) {

        let square = ShapeView(x: location.x, y: location.y)
        view.addSubview(square)
    
        gravity.addItem(square)
        collision.addItem(square)
        dynamicItem.addItem(square)
        
        let thePanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        square.addGestureRecognizer(thePanRecognizer)
    }


}

