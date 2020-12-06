//
//  ViewController.swift
//  rush01
//
//  Created by Kseniya Lukoshkina on 06.12.2020.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var myLocationButton: UIButton!
    
    var destinationMarker: GMSMarker?
    
//    let sourceLat = 28.704060
//    let sourceLng = 77.102493
//
//    let destinationLat = 28.459497
//    let destinationLng = 77.026634
    
    var searchedPlace: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeButton.layer.cornerRadius = routeButton.frame.height / 2
        routeButton.layer.masksToBounds = true
        routeButton.isHidden = true
        myLocationButton.layer.cornerRadius = myLocationButton.frame.height / 2
    }
    
    private func searchPlace() {
        guard let place = searchedPlace else { return }
        routeButton.isHidden = false
        print(place.lat)
        print(place.lnt)
        
        if destinationMarker != nil { destinationMarker?.map = nil }
        destinationMarker = GMSMarker()
        destinationMarker?.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lnt)
        destinationMarker?.title = place.title
        destinationMarker?.map = self.mapView
        
        let camera = GMSCameraPosition(latitude: place.lat, longitude: place.lnt, zoom: 8)
        self.mapView.animate(to: camera)
    }

    @IBAction func editingDidBegin(_ sender: Any) {
        print("click search text field")
        routeButton.isHidden = true
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.delegate = self
        vc.onSuccess = {
            self.searchPlace()
        }
        self.present(vc, animated: false, completion: {})
    }
    
    @IBAction func clickMyLocation(_ sender: Any) {
        print("my location")
    }
    
}

