//
//  CLLocation+Ext.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import CoreLocation


extension CLLocationCoordinate2D: BaseConvertibleType, CoreLocationRepresentable {
    func asCoreLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }

    func asBase() -> Location {
        return self.asCoreLocation().asBase()
    }
}

extension CLLocation: BaseConvertibleType {
    func asBase() -> Location {
        return Location(latitude: self.coordinate.latitude,
                        longitude: self.coordinate.longitude,
                        horizontalAccuracy: self.horizontalAccuracy,
                        verticalAccuracy: self.verticalAccuracy,
                        timestamp: self.timestamp)
    }
}

extension Location: CoreLocationRepresentable {
    func asCoreLocation() -> CLLocation {

        return CLLocation(coordinate: CLLocationCoordinate2D(latitude: self.latitude,
                                                             longitude: self.longitude),
                          altitude: 0.0,
                          horizontalAccuracy: self.horizontalAccuracy,
                          verticalAccuracy: self.verticalAccuracy,
                          timestamp: self.timestamp)
    }
}
