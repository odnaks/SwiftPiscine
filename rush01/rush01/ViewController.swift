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
    
    let sourceLat = 28.704060
    let sourceLng = 77.102493

    let destinationLat = 28.459497
    let destinationLng = 77.026634
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
        
        // google map DIRECTION API
        // https://developers.google.com/maps/documentation/directions/start
        let sourceLocation = "\(sourceLat),\(sourceLng)"
        let destinationLocation = "\(destinationLat),\(destinationLng)"
                
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&mode=driving&key=AIzaSyA3ueoITQrxtyezlVtG6Q3KXQVH1Niv4gA"

        AF.request(url).responseJSON { (reseponse) in
            
                    guard let data = reseponse.data else {
                        return
                    }
                    
                    do {
                        print(data)
                        print("json")
                        let jsonData = try JSON(data: data)
                        print(jsonData)
                        let routes = jsonData["routes"].arrayValue
                        
                        print(routes)
                        
                        for route in routes {
                            print(route)
                            let overview_polyline = route["overview_polyline"].dictionary
                            let points = overview_polyline?["points"]?.string
                            let path = GMSPath.init(fromEncodedPath: points ?? "")
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeColor = .systemBlue
                            polyline.strokeWidth = 5
                            polyline.map = self.mapView
                        }
                    }
                     catch let error {
                        print(error.localizedDescription)
                    }
                }

        
        
        
        
        
        let sourceMarker = GMSMarker()
        sourceMarker.position = CLLocationCoordinate2D(latitude: sourceLat, longitude: sourceLng)
        sourceMarker.title = "Delhi"
        sourceMarker.snippet = "The Capital of INDIA"
        sourceMarker.map = self.mapView


        // MARK: Marker for destination location
        let destinationMarker = GMSMarker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLng)
        destinationMarker.title = "Gurugram"
        destinationMarker.snippet = "The hub of industries"
        destinationMarker.map = self.mapView
        

        let camera = GMSCameraPosition(latitude: sourceLat, longitude: sourceLng, zoom: 10)
        self.mapView.animate(to: camera)
    }


}

