//
//  RMLocation.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

import RealmSwift

class RMLocation: Object {
    @objc dynamic var id = NSUUID().uuidString

    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double  = 0.0

    @objc dynamic var horizontalAccuracy: Double  = 0.0
    @objc dynamic var verticalAccuracy: Double  = 0.0

    @objc dynamic var timestamp: Date = Date()

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMLocation: BaseConvertibleType {
    func asBase() -> Location {
        return Location(latitude: self.latitude,
                        longitude: self.longitude,
                        horizontalAccuracy: self.horizontalAccuracy,
                        verticalAccuracy: self.verticalAccuracy,
                        timestamp: self.timestamp)
    }
}
extension Location: RealmRepresentable {
    func asRealm() -> RMLocation {
        let location = RMLocation()

        location.latitude = self.latitude
        location.longitude = self.longitude
        location.horizontalAccuracy = self.horizontalAccuracy
        location.verticalAccuracy = self.verticalAccuracy
        location.timestamp = self.timestamp

        return location
    }
}
