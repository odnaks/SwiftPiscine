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
    
    var onSuccess: (() -> ())?
    var delegate: ViewController?
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    private func search(text: String) {
        places = []
        
        let url = "https://api.openrouteservice.org/geocode/autocomplete?api_key=5b3ce3597851110001cf6248813a66961c2d47e3bfc3b9bee296ac4f&text='\(text)'"
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
                            guard let coord = geom?["coordinates"]?.arrayValue,
                                  let label = dic?["label"]?.string else { return }
                            let lnt = coord[0].doubleValue
                            let lat = coord[1].doubleValue
                            self.places.append(Place(title: label, lat: lat, lnt: lnt))
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
        if places.count > indexPath.row {
            cell.titleLabel.text = places[indexPath.row].title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: false, completion: {
            self.delegate?.searchedPlace = self.places[indexPath.row]
            self.onSuccess?()
        })
    }
    
}
