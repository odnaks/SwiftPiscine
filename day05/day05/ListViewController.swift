//
//  ListViewController.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 30.11.2020.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var places = [Place]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let path = Bundle.main.url(forResource: "data", withExtension: "json") {
            if let data = try? Data(contentsOf: path) {
                if let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                    for place in dic {
                        if let placeDic = place as? [String: Any] {
                            print(placeDic)
                            let placeModel = Place(name: "", desc: "")
                            print("====")
                        }
                    }
//                    for place in dic {
//                        if let name = place["name"] as? String,
//                            let desc = place["desc"] as? String {
//                            
//                        }
//                    }
                }
//                allWords = startWords.components(separatedBy: "\n")
            }
        }
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        return UITableViewCell()
    }
    
    
}
