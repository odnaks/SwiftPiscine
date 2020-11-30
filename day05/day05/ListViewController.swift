//
//  ListViewController.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 30.11.2020.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.url(forResource: "data", withExtension: "json") {
            if let data = try? Data(contentsOf: path) {
                print(data)
//                allWords = startWords.components(separatedBy: "\n")
            }
        }
    }
    

}
