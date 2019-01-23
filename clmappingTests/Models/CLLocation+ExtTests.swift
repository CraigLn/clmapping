//
//  CLLocation+ExtTests.swift
//  clmappingTests
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import XCTest
import CoreLocation

@testable import clmapping

class CLLocationExtTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testCLLocationCoordinate2D_BaseConvertibleType() {
        // Given
        let sut1 = CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186)
        let sut2 = Location(latitude: 37.33233141, longitude: -122.0312186,
                            horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        // When
        let sut3 = sut1.asBase()

        // Then
        XCTAssertTrue(sut2 == sut3)
    }
    func testCLLocationCoordinate2D_CoreLocationRepresentable() {
        // Given
        let sut1 = CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186)
        let sut2 = CLLocation(latitude: 37.33233141, longitude: -122.0312186)

        // When
        let sut3 = sut1.asCoreLocation()

        // Then
        XCTAssertTrue(sut2.asBase() == sut3.asBase())
    }

    func testCLLocation_BaseConvertibleType() {
        // Given
        let coord = CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186)
        let sut1 = CLLocation(coordinate: coord, altitude: 0.0, horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        let sut2 = Location(latitude: 37.33233141, longitude: -122.0312186,
                            horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        let sut3 = Location(latitude: 40.759211, longitude: -73.984638,
                            horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        // When
        let sut4 = sut1.asBase()

        // Then
        XCTAssertTrue(sut4 == sut2)
        XCTAssertFalse(sut4 == sut3)
    }
    func testLocation_CoreLocationRepresentable() {
        // Given
        let sut1 = Location(latitude: 37.33233141, longitude: -122.0312186,
                            horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        let coord = CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186)
        let sut2 = CLLocation(coordinate: coord, altitude: 0.0, horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        let coord2 = CLLocationCoordinate2D(latitude: 40.759211, longitude: -73.984638)
        let sut3 = CLLocation(coordinate: coord2, altitude: 0.0, horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        // When
        let sut4 = sut1.asCoreLocation()

        // Then
        XCTAssertTrue(sut4.asBase() == sut2.asBase())
        XCTAssertFalse(sut4.asBase() == sut3.asBase())
    }
}
