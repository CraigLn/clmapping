//
//  CLPlacemark+ExtTests.swift
//  clmappingTests
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import XCTest
import CoreLocation
import Contacts
import MapKit

@testable import clmapping

class CLPlacemarkExtTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testCLPlacemark_BaseConvertibleType() {
        // Given
        let addressDict = [CNPostalAddressStreetKey: "W 47th St",
                           CNPostalAddressCityKey: "New York",
                           CNPostalAddressSubLocalityKey: "Manhattan",
                           CNPostalAddressStateKey: "NY",
                           CNPostalAddressSubAdministrativeAreaKey: "New York",
                           CNPostalAddressPostalCodeKey: "10036",
                           CNPostalAddressCountryKey: "United States",
                           CNPostalAddressISOCountryCodeKey: "US"]

        let coord = CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186)
        let sut1 = MKPlacemark(coordinate: coord, addressDictionary: addressDict)

        let sut2 = Placemark(location: coord.asBase(),
                             name: nil,
                             thoroughfare: "W 47th St", subThoroughfare: nil,
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        let sut3 = Placemark(location: nil,
                             name: "Apple Inc.",
                             thoroughfare: "Infinite Loop", subThoroughfare: "1",
                             locality: "Cupertino", subLocality: nil,
                             administrativeArea: "CA", subAdministrativeArea: "Santa Clara",
                             postalCode: "95014", isoCountryCode: "US", country: "United States")

        // When
        let sut4 = sut1.asBase()

        // Then
        XCTAssertTrue(sut4 == sut2)
        XCTAssertFalse(sut4 == sut3)
    }
    func testPlacemark_CoreLocationRepresentable() {
        // Given
        let coord = CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186)
        let sut1 = Placemark(location: coord.asBase(),
                             name: "200 W 47th St",
                             thoroughfare: "W 47th St", subThoroughfare: "200",
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        let addressDict = [CNPostalAddressStreetKey: "W 47th St",
                           CNPostalAddressCityKey: "New York",
                           CNPostalAddressSubLocalityKey: "Manhattan",
                           CNPostalAddressStateKey: "NY",
                           CNPostalAddressSubAdministrativeAreaKey: "New York",
                           CNPostalAddressPostalCodeKey: "10036",
                           CNPostalAddressCountryKey: "United States",
                           CNPostalAddressISOCountryCodeKey: "US"]

        let coord2 = CLLocationCoordinate2D(latitude: 40.759211, longitude: -73.984638)
        let addressDict2 = [CNPostalAddressStreetKey: "Infinite Loop",
                           CNPostalAddressCityKey: "Cupertino",
                           CNPostalAddressStateKey: "CA",
                           CNPostalAddressSubAdministrativeAreaKey: "Santa Clara",
                           CNPostalAddressPostalCodeKey: "95014",
                           CNPostalAddressCountryKey: "United States",
                           CNPostalAddressISOCountryCodeKey: "US"]


        let sut2 = MKPlacemark(coordinate: coord, addressDictionary: addressDict)
        let sut3 = MKPlacemark(coordinate: coord2, addressDictionary: addressDict2)

        // When
        let sut4 = sut1.asCoreLocation()

        // Then
        XCTAssertTrue(sut4.asBase() == sut2.asBase())
        XCTAssertFalse(sut4.asBase() == sut3.asBase())
    }
    func testPlacemark_CoreLocationRepresentableWithNilPlacemarkValues() {
        // Given

        let sut1 = Placemark(location: nil,
                             name: nil,
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: nil, subLocality: nil,
                             administrativeArea: nil, subAdministrativeArea: nil,
                             postalCode: nil, isoCountryCode: nil, country: nil)

        let coord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let addressDict = [CNPostalAddressStreetKey: "",
                           CNPostalAddressCityKey: "",
                           CNPostalAddressSubLocalityKey: "",
                           CNPostalAddressStateKey: "",
                           CNPostalAddressSubAdministrativeAreaKey: "",
                           CNPostalAddressPostalCodeKey: "",
                           CNPostalAddressCountryKey: "",
                           CNPostalAddressISOCountryCodeKey: ""]

        let coord2 = CLLocationCoordinate2D(latitude: 40.759211, longitude: -73.984638)
        let addressDict2 = [CNPostalAddressStreetKey: "Infinite Loop",
                            CNPostalAddressCityKey: "Cupertino",
                            CNPostalAddressStateKey: "CA",
                            CNPostalAddressSubAdministrativeAreaKey: "Santa Clara",
                            CNPostalAddressPostalCodeKey: "95014",
                            CNPostalAddressCountryKey: "United States",
                            CNPostalAddressISOCountryCodeKey: "US"]


        let sut2 = MKPlacemark(coordinate: coord, addressDictionary: addressDict)
        let sut3 = MKPlacemark(coordinate: coord2, addressDictionary: addressDict2)

        // When
        let sut4 = sut1.asCoreLocation()

        // Then
        XCTAssertTrue(sut4.asBase() == sut2.asBase())
        XCTAssertFalse(sut4.asBase() == sut3.asBase())
    }
}
