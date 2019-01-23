//
//  Location.swift
//  clmapping
//
//  Created by Craig Lane on 1/21/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

import MapKit

public struct Location: Codable {
    public let latitude: Double
    public let longitude: Double

    public let horizontalAccuracy: Double
    public let verticalAccuracy: Double

    public let timestamp: Date

    public init(latitude: Double,
                longitude: Double,
                horizontalAccuracy: Double,
                verticalAccuracy: Double,
                timestamp: Date) {

        self.latitude = latitude
        self.longitude = longitude
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
        self.timestamp = timestamp
    }
}

extension Location: Equatable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.asCoreLocation().distance(from: rhs.asCoreLocation()) < 10.0
    }
}
