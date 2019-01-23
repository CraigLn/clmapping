//
//  MapViewModel.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

import CoreLocation

typealias PlacemarkCompletion = (Placemark?, Displayable?) -> Void
typealias LocationPresentableCompletion = ([Location], Displayable?) -> Void

struct MapViewModel {

    var locationService: DeivceLocationService?
    var geocodingService: GeocodingService?
    var databaseService: DatabaseService?

    var dataSource: [Location]

    init() {
        self.databaseService = DatabaseService(locationProvider: DatabaseProvider(), placemarkProvider: DatabaseProvider())
        self.geocodingService = GeocodingService(provider: CLGeocoder())
        self.locationService = DeivceLocationService(provider: CLLocationManager())

        self.dataSource = self.databaseService?.fetchAllLocations() ?? []
    }

    func startLocationUpdates(completion: @escaping LocationCompletion) {
        self.locationService?.startLocationUpdates { (locations, error) in

            self.databaseService?.storeLocations(locations: locations)

            DispatchQueue.main.async {
                if let error = error {
                    completion([], error)
                } else {
                    completion(locations, nil)
                }
            }
        }
    }

    func getPlacemark(from location: Location, completion: @escaping PlacemarkCompletion) {
        // Check if we have existing Placemark stored
        if let placemark = self.databaseService?.fetchPlacemark(for: location).first {
            completion(placemark, nil)
        } else {
            geocodingService?.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemark = placemarks.first {
                    // Store the Placemark
                    self.databaseService?.storePlacemark(placemark: placemark)

                    DispatchQueue.main.async {
                        completion(placemark, nil)
                    }
                }
            }
        }
    }
}
