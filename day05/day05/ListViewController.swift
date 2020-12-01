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
                            if let name = placeDic["name"] as? String, let desc = placeDic["desc"] as? String {
                                let placeModel = Place(name: name, desc: desc)
                                places.append(placeModel)
                                print(placeDic)
                                print("====")
                            }
                        }
                    }
                    tableView.reloadData()
                }
            }
        }
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as? PlaceCell else { return UITableViewCell() }
        cell.nameLabel.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 0
        se
    }
    
    
}
