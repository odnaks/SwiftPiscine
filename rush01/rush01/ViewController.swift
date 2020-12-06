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
    
//    let sourceLat = 28.704060
//    let sourceLng = 77.102493
//
//    let destinationLat = 28.459497
//    let destinationLng = 77.026634
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        let sourceMarker = GMSMarker()
//        sourceMarker.position = CLLocationCoordinate2D(latitude: sourceLat, longitude: sourceLng)
//        sourceMarker.title = "Delhi"
//        sourceMarker.snippet = "The Capital of INDIA"
//        sourceMarker.map = self.mapView
//
//
//        // MARK: Marker for destination location
//        let destinationMarker = GMSMarker()
//        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLng)
//        destinationMarker.title = "Gurugram"
//        destinationMarker.snippet = "The hub of industries"
//        destinationMarker.map = self.mapView
//
//
//        let camera = GMSCameraPosition(latitude: sourceLat, longitude: sourceLng, zoom: 10)
//        self.mapView.animate(to: camera)
    }

    @IBAction func editingDidBegin(_ sender: Any) {
        print("click search text field")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchViewController")
        self.present(vc, animated: false, completion: {})
    }
    
}

