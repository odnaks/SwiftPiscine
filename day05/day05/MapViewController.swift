//
//  MapViewController.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 01.12.2020.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        
        let location = CLLocation(latitude: 48.89741, longitude: 2.3181474)
        self.centerMapOnLocation(location: location)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
   func centerMapOnLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "Ecole 42"
            annotation.subtitle = "Paris, France"
            self.mapView.addAnnotation(annotation)
        }
   }
    
    @IBAction func changeSelect(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func showMy(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location2d = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: location2d, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        locationManager.stopUpdatingLocation()

    }
}
