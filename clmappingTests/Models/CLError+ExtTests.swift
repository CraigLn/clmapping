//
//  CLError+ExtTests.swift
//  clmappingTests
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import XCTest
import CoreLocation

import UIKit

@testable import clmapping

class CLErrorExtTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testSwiftErrorPresentable() {
        // Given
        let sut1 = "Error Title"
        let sut2 = "Error Message"

        // When
        struct testError: Swift.Error, Displayable {
            var title: String {
                return "Error Title"
            }

            var message: String {
                return "Error Message"
            }
        }

        // Then
        XCTAssertTrue(testError().presentable.title == sut1)
        XCTAssertTrue(testError().presentable.message == sut2)
    }

    func testCLErrorPresentableTitle() {
        // Given
        let sut1: LocationErrorType = CLError(.locationUnknown)
        let sut2: LocationErrorType = CLError(.denied)
        let sut3: LocationErrorType = CLError(.network)

        let sut4: LocationErrorType = CLError(.geocodeFoundNoResult)
        let sut5: LocationErrorType = CLError(.geocodeFoundPartialResult)
        let sut6: LocationErrorType = CLError(.geocodeCanceled)

        let sut7: LocationErrorType = CLError(.deferredFailed)
        let sut8: LocationErrorType = CLError(.deferredNotUpdatingLocation)
        let sut9: LocationErrorType = CLError(.deferredAccuracyTooLow)
        let sut10: LocationErrorType = CLError(.deferredDistanceFiltered)
        let sut11: LocationErrorType = CLError(.deferredCanceled)

        let sut12: LocationErrorType = CLError(.headingFailure)

        // Then
        XCTAssertTrue(sut1.title == "Location Unknown")
        XCTAssertTrue(sut2.title == "Location Disable")
        XCTAssertTrue(sut3.title == "Netwwork Error")
        XCTAssertTrue(sut4.title == "Geo Coding Error")
        XCTAssertTrue(sut5.title == "Geo Coding Error")
        XCTAssertTrue(sut6.title == "Geo Coding Error")

        XCTAssertTrue(sut7.title == "Deferred Error")
        XCTAssertTrue(sut8.title == "Deferred Error")
        XCTAssertTrue(sut9.title == "Deferred Error")
        XCTAssertTrue(sut10.title == "Deferred Error")
        XCTAssertTrue(sut11.title == "Deferred Error")

        XCTAssertTrue(sut12.title == "Location Error")
    }

    func testCLErrorPresentableMessage() {
        // Given
        let sut1: LocationErrorType = CLError(.denied)
        let sut2: LocationErrorType = CLError(.deferredAccuracyTooLow)

        // Then
        XCTAssertTrue(sut1.message == "Please enable Location Services in the Settings App")
        XCTAssertTrue(sut2.message == sut2.localizedDescription)
    }

    func testCLAuthorizationStatus_BaseConvertibleType() {
        // Given
        let sut1 = CLAuthorizationStatus(rawValue: 0)!
        let sut2 = CLAuthorizationStatus(rawValue: 1)!
        let sut3 = CLAuthorizationStatus(rawValue: 2)!
        let sut4 = CLAuthorizationStatus(rawValue: 3)!
        let sut5 = CLAuthorizationStatus(rawValue: 4)!

        // Then
        switch sut1.asBase() {
        case .notAllowed(_):
             XCTAssertTrue(true)
        default:
            XCTFail()
        }
        switch sut2.asBase() {
        case .notAllowed(_):
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
        switch sut3.asBase() {
        case .notAllowed(_):
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
        switch sut4.asBase() {
        case .always:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
        switch sut5.asBase() {
        case .foreground:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
    }

    func testDeviceLocationPermission_CoreLocationRepresentable() {

        // Given
        let sut1 = DeviceLocationPermission.notAllowed(DeviceLocationError.failedAuthorization)
        let sut2 = DeviceLocationPermission.foreground
        let sut3 = DeviceLocationPermission.always

        // Then
        switch sut1.asCoreLocation() {
        case .denied:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
        switch sut2.asCoreLocation() {
        case .authorizedWhenInUse:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
        switch sut3.asCoreLocation() {
        case .authorizedAlways:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
    }
}
