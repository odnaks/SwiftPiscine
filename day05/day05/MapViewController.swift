//
//  MapViewController.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 01.12.2020.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate {
    func centerMap(with place: Place)
}

class MapViewController: UIViewController, MapViewControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.standard

        showAllPins()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
   func centerMap(with place: Place) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
   }
    
    private func showAllPins() {
        for place in Singleton.shared.places {
            let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            let annotation = CustomPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = place.name
            annotation.subtitle = place.desc
            annotation.color = place.color
            annotation.identifier = place.colorString
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKMarkerAnnotationView()
        guard let annotation = annotation as? CustomPointAnnotation else {return nil}
        let identifier = annotation.identifier ?? "default"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            annotationView = view
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView.markerTintColor = annotation.color
        annotationView.clusteringIdentifier = identifier
        return annotationView
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

