//
//  DeviceLocationService.swift
//  clmapping
//
//  Created by Craig Lane on 1/22/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import CoreLocation

import UIKit

typealias LocationCompletion = ([Location], LocationErrorType?) -> Void

// MARK: Errors
enum DeviceLocationError: LocationErrorType {
    case failedAuthorization

    var title: String {
        switch self {
        case .failedAuthorization:
            return NSLocalizedString("Location Disable",
                                     comment: "Location Disable")
        }
    }

    var message: String {
        switch self {
        case .failedAuthorization:
            return NSLocalizedString("Please enable Location Services in the Settings App",
                                     comment: "Please enable Location Services in the Settings App")
        }
    }
}

// MARK: Provider
enum DeviceLocationPermission {
    case always
    case foreground
    case notAllowed(LocationErrorType)
}

protocol Authorized {
    var isAuthorized: Bool { get }
}

extension DeviceLocationPermission {
    var isAuthorized: Bool {
        switch self {
        case .always, .foreground:
            return true
        case .notAllowed:
            return false
        }
    }
}

// TODO: Refactor name for Authorized
protocol DeviceLocationProvider: Authorized {
    // Underlying Delegate
    var protocolDelegate: AnyObject? { get set }

    // Authorization
    func requestAlwaysAuthorization()
    var allowsBackgroundLocationUpdates: Bool { get set }

    // GPS
    var distanceFilter: Double { get set }
    var desiredAccuracy: Double { get set }
    var pausesLocationUpdatesAutomatically: Bool { get set }
    func requestLocation()
    func startUpdatingLocation()
    func stopUpdatingLocation()

    // SLC
    func startMonitoringSignificantLocationChanges()
    func stopMonitoringSignificantLocationChanges()
}

extension CLLocationManager: DeviceLocationProvider, Authorized {
    var protocolDelegate: AnyObject? {
        get {
            return self.delegate
        }
        set(protocolDelegate) {
            self.delegate = protocolDelegate as? CLLocationManagerDelegate
        }
    }

    var isAuthorized: Bool {
        return CLLocationManager.authorizationStatus().asBase().isAuthorized
    }
}

protocol ImmediateLocationProvider {
    func getLocation(completion: @escaping LocationCompletion)
}

protocol ContinuousLocationProvider {
    var isActive: Bool { get }
    func startLocationUpdates(completion: @escaping LocationCompletion)
    func stopLocationUpdates()
}

// MARK: Service
class DeivceLocationService: NSObject, ContinuousLocationProvider {
    private var provider: DeviceLocationProvider
    private var latestLocationUpdate: LocationCompletion?

    private var latestLocation: CLLocation?

    private (set) var isActive: Bool

    init(provider: DeviceLocationProvider) {
        self.provider = provider

        self.provider.allowsBackgroundLocationUpdates = true
        // Enabled for better batter performce while in background
        self.provider.pausesLocationUpdatesAutomatically = true
        self.provider.desiredAccuracy = kCLLocationAccuracyThreeKilometers

        self.isActive = false

        super.init()

        self.provider.protocolDelegate = self
    }

    func startLocationUpdates(completion: @escaping LocationCompletion) {
        // Set the delegate Listener
        latestLocationUpdate = completion

        // Perform necessary actions
        if provider.isAuthorized {
            provider.startUpdatingLocation()
        } else {
            provider.requestAlwaysAuthorization()
        }
    }

    func stopLocationUpdates() {
        provider.stopUpdatingLocation()
        isActive = false
    }
}

extension DeivceLocationService: CLLocationManagerDelegate {
    // Authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status.asBase() {
        case .always, .foreground:
            provider.startUpdatingLocation()
        case .notAllowed(let error):
            latestLocationUpdate?([], error)
        }
    }

    // Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latestLocation = latestLocation,
            locations.last?.distance(from: latestLocation) ?? 100.0 < kCLLocationAccuracyNearestTenMeters {

        } else {
            latestLocationUpdate?(locations.map { $0.asBase() }, nil)
            latestLocation = locations.last
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isActive = false
        latestLocationUpdate?([], error as? LocationErrorType)
    }

    // Handling Pausing
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        isActive = false
    }

    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        isActive = true
    }
}
