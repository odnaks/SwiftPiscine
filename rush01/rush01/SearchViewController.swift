//
//  SearchViewController.swift
//  rush01
//
//  Created by Kseniya Lukoshkina on 06.12.2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var places = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    private func search(text: String) {
        let url = "https://api.openrouteservice.org/geocode/autocomplete?api_key=5b3ce3597851110001cf6248813a66961c2d47e3bfc3b9bee296ac4f&text=\(text)"
//
        AF.request(url).responseJSON { (reseponse) in

                    guard let data = reseponse.data else {
                        return
                    }

                    do {
//                        print(data)
                        print("json")
                        let jsonData = try JSON(data: data)
//                        print(jsonData)
                        let routes = jsonData["features"].arrayValue
//                        print(routes)
                        for route in routes {
                            let dic = route["properties"].dictionary
                            let geom = route["geometry"].dictionary
                            let coord = geom?["coordinates"]?.arrayValue
                            let label = dic?["label"]?.string
                            print(dic!["label"])
                            print(coord)
                            self.places.append(label!)
                        }
////
//                        print(routes)
//
//                        for route in routes {
//                            print(route)
//                            let overview_polyline = route["overview_polyline"].dictionary
//                            let points = overview_polyline?["points"]?.string
//                            let path = GMSPath.init(fromEncodedPath: points ?? "")
//                            let polyline = GMSPolyline.init(path: path)
//                            polyline.strokeColor = .systemBlue
//                            polyline.strokeWidth = 5
//                            polyline.map = self.mapView
//                        }
                        self.tableView.reloadData()
                    }
                     catch let error {
                        print("error")
                        print(error.localizedDescription)
                    }
                }

    }
    
    @IBAction func clickButton(_ sender: Any) {
        print("click search button")
        guard let text = searchTextField.text else { return }
        search(text: text)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        cell.titleLabel.text = places[indexPath.row]
        return cell
    }
    
    
}