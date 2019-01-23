//
//  PlacemarkTests.swift
//  clmappingTests
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import XCTest
@testable import clmapping

class PlacemarkTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {
    }

    func testInitialization() {
        // Given
        let location = Location(latitude: 37.33233141, longitude: -122.0312186,
                                horizontalAccuracy: 100.0, verticalAccuracy: -1.0, timestamp: Date.distantPast)
        let name = "200 W 47th St"
        let thoroughfare = "W 47th St"
        let subThoroughfare = "200"
        let locality = "New York"
        let subLocality = "Manhattan"
        let administrativeArea = "NY"
        let subAdministrativeArea = "New York"
        let postalCode = "10036"
        let isoCountryCode = "US"
        let country = "United States"

        // When
        let sut = Placemark(location: location, name: name, thoroughfare: thoroughfare, subThoroughfare: subThoroughfare, locality: locality, subLocality: subLocality, administrativeArea: administrativeArea, subAdministrativeArea: subAdministrativeArea, postalCode: postalCode, isoCountryCode: isoCountryCode, country: country)

        // Then
        XCTAssertTrue(sut.location == location)
        XCTAssertTrue(sut.name == name)
        XCTAssertTrue(sut.thoroughfare == thoroughfare)
        XCTAssertTrue(sut.subThoroughfare == subThoroughfare)
        XCTAssertTrue(sut.locality == locality)
        XCTAssertTrue(sut.subLocality == subLocality)
        XCTAssertTrue(sut.administrativeArea == administrativeArea)
        XCTAssertTrue(sut.subAdministrativeArea == subAdministrativeArea)
        XCTAssertTrue(sut.postalCode == postalCode)
        XCTAssertTrue(sut.isoCountryCode == isoCountryCode)
        XCTAssertTrue(sut.country == country)
    }

    func testInitializationFromPlacemark() {
        // Given
        let sut1 = Location(latitude: 37.33233141, longitude: -122.0312186,
                                horizontalAccuracy: 100.0, verticalAccuracy: -1.0, timestamp: Date.distantPast)


        let sut2 = Placemark(location: sut1,
                             name: "200 W 47th St",
                             thoroughfare: "W 47th St", subThoroughfare: "200",
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        let sut3 = Location(latitude: 40.759211, longitude: -73.984638,
                           horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)


        // When
        let sut4 = Placemark(placemark: sut2, with: sut3)

        // Then
        XCTAssertTrue(sut2.location == sut1)

        XCTAssertFalse(sut2 == sut4)

        XCTAssertTrue(sut4.location == sut3)
    }

    func testEquality() {
        // Given
        let loc = Location(latitude: 37.33233141, longitude: -122.0312186,
                            horizontalAccuracy: 100.0, verticalAccuracy: -1.0, timestamp: Date.distantPast)

        let sut1 = Placemark(location: loc,
                             name: "200 W 47th St",
                             thoroughfare: "W 47th St", subThoroughfare: "200",
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        // When
        let sut2 = Placemark(location: loc,
                             name: "200 W 47th St",
                             thoroughfare: "W 47th St", subThoroughfare: "200",
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        let sut3 = Placemark(location: nil,
                             name: "Apple Inc.",
                             thoroughfare: "Infinite Loop", subThoroughfare: "1",
                             locality: "Cupertino", subLocality: nil,
                             administrativeArea: "CA", subAdministrativeArea: "Santa Clara",
                             postalCode: "95014", isoCountryCode: "US", country: "United States")



        // Then
        XCTAssertTrue(sut1 == sut2)
        XCTAssertFalse(sut1 == sut3)
    }

    func testDisplayableTitleWithStreetInfo() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: "200 W 47th St",
                             thoroughfare: "W 47th St", subThoroughfare: "200",
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        // When
        let sut2 = "200 W 47th St"

        // Then
        XCTAssertTrue(sut1.title == sut2)
    }

    func testDisplayableTitleWithName() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: "200 W 47th St",
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        // When
        let sut2 = "Near 200 W 47th St"

        // Then
        XCTAssertTrue(sut1.title == sut2)
    }

    func testDisplayableTitleWithoutValues() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: nil,
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        // When
        let sut2 = ""

        // Then
        XCTAssertTrue(sut1.title == sut2)
    }

    func testDisplayableMessageWithAllValues() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: nil,
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: "10036", isoCountryCode: "US", country: "United States")

        // When
        let sut2 = "New York, NY 10036 US"

        // Then
        XCTAssertTrue(sut1.message == sut2)
    }

    func testDisplayableMessageWithoutPostalWithIsoCode() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: nil,
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: nil, isoCountryCode: "US", country: "United States")

        // When
        let sut2 = "New York, NY US"

        // Then
        XCTAssertTrue(sut1.message == sut2)
    }

    func testDisplayableMessageWithoutPostalWithFullCountry() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: nil,
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: "New York", subLocality: "Manhattan",
                             administrativeArea: "NY", subAdministrativeArea: "New York",
                             postalCode: nil, isoCountryCode: nil, country: "United States")

        // When
        let sut2 = "New York, NY United States"

        // Then
        XCTAssertTrue(sut1.message == sut2)
    }

    func testDisplayableMessageWithoutValues() {
        // Given
        let sut1 = Placemark(location: nil,
                             name: nil,
                             thoroughfare: nil, subThoroughfare: nil,
                             locality: nil, subLocality: nil,
                             administrativeArea: nil, subAdministrativeArea: nil,
                             postalCode: nil, isoCountryCode: nil, country: nil)

        // When
        let sut2 = ""

        // Then
        XCTAssertTrue(sut1.message == sut2)
    }
}

