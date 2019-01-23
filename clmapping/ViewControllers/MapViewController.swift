//
//  MapViewController.swift
//  clmapping
//
//  Created by Craig Lane on 1/21/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var viewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
        self.mapView.userTrackingMode = .follow

        let annotations = viewModel.dataSource.map { location -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                           longitude: location.longitude)
            return annotation
        }
        mapView.addAnnotations(annotations)

        // For Authoriztion Changes
        self.viewModel.startLocationUpdates { (locations, displayableError) in
            if let displayableError = displayableError {
                // Display Error
                self.present(displayableError.presentable, animated: true, completion: nil)
            } else {
                let annotations = locations.map { location -> MKPointAnnotation in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                                   longitude: location.longitude)
                    return annotation
                }

                self.mapView.addAnnotations(annotations)
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        // Only interested in displaying current address
        guard view.annotation?.isKind(of: MKUserLocation.self) ?? false,
            let location = view.annotation?.coordinate.asBase() else {
            return
        }

        viewModel.getPlacemark(from: location) { (placemark, error) in
            if let placemark = placemark {
                self.mapView.userLocation.title = placemark.title
                self.mapView.userLocation.subtitle = placemark.message
            }
        }
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
}
