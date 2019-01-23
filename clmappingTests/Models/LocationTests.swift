//
//  Location.swift
//  clmappingTests
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import XCTest
@testable import clmapping

class LocationTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {
    }

    func testInitialization() {
        // Given
        let lat = 37.33233141
        let long = -122.0312186
        let horAcc = 100.0
        let vertAcc = -1.0
        let time = Date()

        // When
        let sut = Location(latitude: lat, longitude: long,
                                horizontalAccuracy: horAcc, verticalAccuracy: vertAcc, timestamp: time)

        // Then
        XCTAssertTrue(sut.latitude == lat)
        XCTAssertTrue(sut.longitude == long)
        XCTAssertTrue(sut.horizontalAccuracy == horAcc)
        XCTAssertTrue(sut.verticalAccuracy == vertAcc)
        XCTAssertTrue(sut.timestamp == time)
    }

    func testEquality() {
        // Given
        let sut1 = Location(latitude: 37.33233141, longitude: -122.0312186,
                                 horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        // When
        let sut2 = Location(latitude: 37.33233141, longitude: -122.0312186,
                                 horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        let sut3 = Location(latitude: 40.759211, longitude: -73.984638,
                            horizontalAccuracy: 100, verticalAccuracy: -1, timestamp: Date.distantPast)

        // Then
        XCTAssertTrue(sut1 == sut2)
        XCTAssertFalse(sut1 == sut3)
    }
}
