//
//  ViewController.swift
//  day06
//
//  Created by Kseniya Lukoshkina on 01.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @objc func handleLongPressGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: self.view)
        addShape(location: location)
//        self.view.addSubview(ShapeView(x: location.x, y: location.y))
        
        print("gesture")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleLongPressGesture(_:)))
        view.addGestureRecognizer(recognizer)
        
    }
    
    private func addShape(location: CGPoint) {
//        guard let x = location.x as? Int, let y = location.y as? Int else { return }
        view.addSubview(ShapeView(x: location.x, y: location.y))
    }


}

