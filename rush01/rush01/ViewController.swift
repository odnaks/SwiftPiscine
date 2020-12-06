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
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var myLocationButton: UIButton!
    
    private let locationManager = CLLocationManager()
    private var destinationMarker: GMSMarker?
    
    var searchedPlace: Place?
    private var currentLocation: CLLocation?
    
    private var fromPlace: Place?
    private var destinationPlace: Place?
    
    private var polyline: GMSPolyline?
    private var path: GMSMutablePath?
    
    @IBOutlet weak var oneTextField: UITextField!
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var miniRouteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeButton.layer.cornerRadius = routeButton.frame.height / 2
        routeButton.layer.masksToBounds = true
        miniRouteButton.layer.cornerRadius = miniRouteButton.frame.height / 2
        miniRouteButton.layer.masksToBounds = true
        
        routeButton.isHidden = true
        myLocationButton.layer.cornerRadius = myLocationButton.frame.height / 2
        
        
        fromTextField.isHidden = true
        destinationTextField.isHidden = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        locationManager.stopUpdatingLocation()
    }
    
    private func searchPlace() {
        guard let place = searchedPlace else { return }
        oneTextField.isHidden = true
        routeButton.isHidden = true
        fromTextField.isHidden = false
        destinationTextField.isHidden = false
        miniRouteButton.isHidden = false
        
        fromTextField.text = "my location"
        destinationTextField.text = destinationPlace?.title
    
        routeButton.isHidden = false
//        print(place.lat)
//        print(place.lnt)
        
        if destinationMarker != nil { destinationMarker?.map = nil }
        destinationMarker = GMSMarker()
        destinationMarker?.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lnt)
        destinationMarker?.title = place.title
        destinationMarker?.map = self.mapView
        
        let camera = GMSCameraPosition(latitude: place.lat, longitude: place.lnt, zoom: 8)
        self.mapView.animate(to: camera)
    }

    
    @IBAction func oneBeginClick(_ sender: Any) {
        print("one Field Click")
        routeButton.isHidden = true
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.delegate = self
        vc.onSuccess = {
            self.destinationPlace = self.searchedPlace
            self.searchPlace()
        }
        self.present(vc, animated: false, completion: {})
    }

    @IBAction func fromBeginClick(_ sender: Any) {
        print("from Field Click")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.delegate = self
        vc.onSuccess = {
            self.fromPlace = self.searchedPlace
            self.fromTextField.text = self.searchedPlace?.title
        }
        self.present(vc, animated: false, completion: {})
    }
    
    @IBAction func destinationBeginClick(_ sender: Any) {
        print("destination Field Click")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.delegate = self
        vc.onSuccess = {
            self.destinationPlace = self.searchedPlace
            self.destinationTextField.text = self.searchedPlace?.title
        }
        self.present(vc, animated: false, completion: {})
    }
    
    @IBAction func clickMyLocation(_ sender: Any) {
        print("my location")
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func clickRoute(_ sender: Any) {
        guard let destination = destinationPlace else { return }
        if let fromPlace = self.fromPlace {
            self.getDirection(startLnt: destination.lnt, startLat: destination.lat,
                         endLnt: fromPlace.lnt, endLat: fromPlace.lat)
        } else if let fromPlace = self.currentLocation {
            self.getDirection(startLnt: destination.lnt, startLat: destination.lat,
                         endLnt: fromPlace.coordinate.longitude, endLat: fromPlace.coordinate.latitude)
        }
        routeButton.isHidden = true
    }
    
    private func drawPath() {
        guard let path = self.path else { return }
        
        polyline?.map = nil
        polyline = GMSPolyline()
        polyline?.strokeWidth = 5
        polyline?.strokeColor = UIColor(red: 0.387, green: 0.502, blue: 0.899, alpha: 1.0)
        polyline?.map = mapView
        polyline?.path = path
        
        let bounds = GMSCoordinateBounds(path: path)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
        mapView.moveCamera(update)
    }
    
    private func showError() {
        let alert = UIAlertController(title: "error", message: ":(", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: {_ in })
        alert.addAction(action)
        self.show(alert, sender: nil)
    }
    
    private func getDirection(startLnt: Double, startLat: Double, endLnt: Double, endLat: Double) {
        self.path = GMSMutablePath()
        let url = "https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248813a66961c2d47e3bfc3b9bee296ac4f&start=\(startLnt),\(startLat)&end=\(endLnt),\(endLat)"
        AF.request(url).responseJSON { (reseponse) in

                    guard let data = reseponse.data else {
                        return
                    }

                    do {
                        print("json")
                        let jsonData = try JSON(data: data)
                        let features = jsonData["features"].arrayValue
                        guard !features.isEmpty, let feature = features[0].dictionary,
                              let geometry = feature["geometry"]?.dictionary,
                              let coordinates = geometry["coordinates"]?.arrayValue else { self.showError(); return }
                        for coordinate in coordinates {
                            let coord = coordinate.arrayValue
                            if coord.count == 2 {
                                let lat: Double = coord[1].doubleValue
                                let lnt: Double = coord[0].doubleValue

                                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lnt)
                                self.path?.add(location)
                            } else {self.showError()}
                        }
                        self.drawPath()
                    }
                     catch let error {
                        print("error")
                        self.showError()
                    }
                }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let location = locations[0]
        currentLocation = location
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let location2d = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: location2d, span: span)
//            mapView.setRegion(region, animated: true)
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        self.mapView.animate(to: camera)
        self.mapView.isMyLocationEnabled = true
//
        locationManager.stopUpdatingLocation()

    }
}
