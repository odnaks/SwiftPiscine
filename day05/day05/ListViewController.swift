//
//  ListViewController.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 30.11.2020.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.shared.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as? PlaceCell else { return UITableViewCell() }
        cell.nameLabel.text = Singleton.shared.places[indexPath.row].name
        cell.descLabel.text = Singleton.shared.places[indexPath.row].desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 0
        if let vc = self.tabBarController?.viewControllers?[0] as? MapViewControllerDelegate {
            vc.centerMap(with: Singleton.shared.places[indexPath.row])
        }
    }
    
}
