//
//  GeocodingService.swift
//  clmapping
//
//  Created by Craig Lane on 1/22/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import CoreLocation

typealias GeocodeCompletionHandler = ([Placemark], LocationErrorType?) -> Void

protocol GeocoderProvider {
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: GeocoderProvider {}

class GeocodingService {

    var provider: GeocoderProvider

    init(provider: GeocoderProvider) {
        self.provider = provider
    }

    func reverseGeocodeLocation(_ location: Location, completion: @escaping GeocodeCompletionHandler) {        
        // Process a new coding event
        provider.reverseGeocodeLocation(location.asCoreLocation()) { (placemarks, error) in
            guard let placemarks = placemarks else {
                return
            }

            completion(placemarks.map({ $0.asBase() }), error as? LocationErrorType)
        }
    }
}
