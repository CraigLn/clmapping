//
//  Placemark.swift
//  clmapping
//
//  Created by Craig Lane on 1/21/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

import MapKit

protocol Displayable {
    var title: String { get }
    var message: String { get }
}

public struct Placemark: Codable {

    public let location: Location?

    public let name: String?
    // City
    public let locality: String?
    public let subLocality: String?
    // Street
    public let thoroughfare: String?
    public let subThoroughfare: String?
    // State/Province
    public let administrativeArea: String?
    public let subAdministrativeArea: String?
    // Zip
    public let postalCode: String?

    // Country
    public let country: String?
    public let isoCountryCode: String? // Abrv

    init(location: Location?,
         name: String?,
         thoroughfare: String?,
         subThoroughfare: String?,
         locality: String?,
         subLocality: String?,
         administrativeArea: String?,
         subAdministrativeArea: String?,
         postalCode: String?,
         isoCountryCode: String?,
         country: String?) {

        self.location = location
        self.name = name
        self.thoroughfare = thoroughfare
        self.subThoroughfare = subThoroughfare
        self.locality = locality
        self.subLocality = subLocality
        self.administrativeArea = administrativeArea
        self.subAdministrativeArea = subAdministrativeArea
        self.postalCode = postalCode
        self.isoCountryCode = isoCountryCode
        self.country = country
    }

    init(placemark: Placemark, with location: Location) {
        self.location = location
        self.name = placemark.name
        self.thoroughfare = placemark.thoroughfare
        self.subThoroughfare = placemark.subThoroughfare
        self.locality = placemark.locality
        self.subLocality = placemark.subLocality
        self.administrativeArea = placemark.administrativeArea
        self.subAdministrativeArea = placemark.subAdministrativeArea
        self.postalCode = placemark.postalCode
        self.isoCountryCode = placemark.isoCountryCode
        self.country = placemark.country
    }
}

extension Placemark: Equatable {
    public static func == (lhs: Placemark, rhs: Placemark) -> Bool {
        return lhs.location == rhs.location &&
            lhs.name == rhs.name &&
            lhs.thoroughfare == rhs.thoroughfare &&
            lhs.subThoroughfare == rhs.subThoroughfare &&
            lhs.locality == rhs.locality &&
            lhs.subLocality == rhs.subLocality &&
            lhs.administrativeArea == rhs.administrativeArea &&
            lhs.subAdministrativeArea == rhs.subAdministrativeArea &&
            lhs.postalCode == rhs.postalCode &&
            lhs.isoCountryCode == rhs.isoCountryCode &&
            lhs.country == rhs.country
    }
}

extension Placemark: Displayable {
    var title: String {
        if let streetNumber = subThoroughfare, let street = thoroughfare {
            return "\(streetNumber) \(street)"
        } else if let shortName = name {
            return "Near \(shortName)"
        }

        return ""
    }

    var message: String {
        if let city = subAdministrativeArea, let state = administrativeArea {
            var message = "\(city), \(state)"

            if let postalCode = postalCode {
                message = "\(message) \(postalCode)"
            }

            if let countryCode = isoCountryCode {
                message = "\(message) \(countryCode)"
            } else if let countryFull = country {
                message = "\(message) \(countryFull)"
            }
            return message
        }

        return ""
    }
}
