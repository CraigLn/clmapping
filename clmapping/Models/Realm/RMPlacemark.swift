//
//  RMPlacemark.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

import RealmSwift

class RMPlacemark: Object {
    @objc dynamic var id = NSUUID().uuidString

    @objc dynamic var location: RMLocation?

    @objc dynamic var name: String?

    @objc dynamic var locality: String?
    @objc dynamic var subLocality: String?

    @objc dynamic var thoroughfare: String?
    @objc dynamic var subThoroughfare: String?

    @objc dynamic var administrativeArea: String?
    @objc dynamic var subAdministrativeArea: String?

    @objc dynamic var postalCode: String?

    @objc dynamic var country: String?
    @objc dynamic var isoCountryCode: String?

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMPlacemark: BaseConvertibleType {
    func asBase() -> Placemark {
        return Placemark(location: self.location?.asBase(),
                         name: self.name,
                         thoroughfare: self.thoroughfare,
                         subThoroughfare: self.subThoroughfare,
                         locality: self.locality,
                         subLocality: self.subLocality,
                         administrativeArea: self.administrativeArea,
                         subAdministrativeArea: self.subAdministrativeArea,
                         postalCode: self.postalCode,
                         isoCountryCode: self.isoCountryCode,
                         country: self.country)
    }
}

extension Placemark: RealmRepresentable {
    func asRealm() -> RMPlacemark {
        let placemark = RMPlacemark()

        placemark.location = self.location?.asRealm()
        placemark.name = self.name

        placemark.locality = self.locality
        placemark.subLocality = self.subLocality

        placemark.thoroughfare = self.thoroughfare
        placemark.subThoroughfare = self.subThoroughfare

        placemark.administrativeArea = self.administrativeArea
        placemark.subAdministrativeArea = self.subAdministrativeArea

        placemark.postalCode = self.postalCode

        placemark.country = self.country
        placemark.isoCountryCode = self.isoCountryCode

        return placemark
    }
}
