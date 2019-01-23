//
//  CLPlacemark+Ext.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Contacts

extension CLPlacemark: BaseConvertibleType {
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

extension Placemark: CoreLocationRepresentable {
    func asCoreLocation() -> CLPlacemark {
        let addressDict = [CNPostalAddressStreetKey: self.thoroughfare ?? "",
                           CNPostalAddressCityKey: self.locality ?? "",
                           CNPostalAddressSubLocalityKey: self.subLocality ?? "",
                           CNPostalAddressStateKey: self.administrativeArea ?? "",
                           CNPostalAddressSubAdministrativeAreaKey: self.subAdministrativeArea ?? "",
                           CNPostalAddressPostalCodeKey: self.postalCode ?? "",
                           CNPostalAddressCountryKey: self.country ?? "",
                           CNPostalAddressISOCountryCodeKey: self.isoCountryCode ?? ""]

        return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.location?.latitude ?? 0.0,
                                                                         longitude: self.location?.longitude ?? 0.0),
                           addressDictionary: addressDict)
    }
}
