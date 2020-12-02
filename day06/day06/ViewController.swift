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
        guard let shapeView = gestureRecognizer.view as? ShapeView else { return }
        switch gestureRecognizer.state {
            case .began:
                gravity.removeItem(shapeView)
            case .changed:
                collision.removeItem(shapeView)
                dynamicItem.removeItem(shapeView)
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
    
    @objc func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        print("GR - pinch")
        guard let shapeView = gestureRecognizer.view as? ShapeView else { return }
        switch gestureRecognizer.state {
            case .began:
                gravity.removeItem(shapeView)
            case .changed:
                collision.removeItem(shapeView)
                dynamicItem.removeItem(shapeView)
                if let savedSize = shapeView.savedSize {
                    shapeView.bounds.size.width = savedSize.width * gestureRecognizer.scale
                    shapeView.bounds.size.height = savedSize.height * gestureRecognizer.scale
                }
                if let shape = shapeView.shape, shape == .circle {
                    shapeView.setCorner()
                }
                collision.addItem(shapeView)
                dynamicItem.addItem(shapeView)
                animator.updateItem(usingCurrentState: shapeView)
            case .ended, .cancelled, .failed:
                gravity.addItem(shapeView)
                shapeView.savedSize = shapeView.bounds.size
            default:
                break
        }
    }
    
    @objc func handleRotateGesture(_ gestureRecognizer: UIRotationGestureRecognizer) {
        print("GR - rotate")
        guard let shapeView = gestureRecognizer.view as? ShapeView else { return }
        switch gestureRecognizer.state {
            case .began:
                gravity.removeItem(shapeView)
            case .changed:
                collision.removeItem(shapeView)
                dynamicItem.removeItem(shapeView)
                shapeView.transform = shapeView.transform.rotated(by: gestureRecognizer.rotation)
                gestureRecognizer.rotation = 0.0
                collision.addItem(shapeView)
                dynamicItem.addItem(shapeView)
                animator.updateItem(usingCurrentState: shapeView)
            case .ended, .cancelled, .failed:
                gravity.addItem(shapeView)
            default:
                break
        }
    }
    
    private func addShape(location: CGPoint) {

        let square = ShapeView(x: location.x, y: location.y)
        view.addSubview(square)
    
        gravity.addItem(square)
        collision.addItem(square)
        dynamicItem.addItem(square)
        
        let thePanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        square.addGestureRecognizer(thePanRecognizer)
        
        let thePinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        square.addGestureRecognizer(thePinchRecognizer)
        
        let theRotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotateGesture(_:)))
        square.addGestureRecognizer(theRotateRecognizer)
    }


}

