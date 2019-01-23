//
//  CLError+Ext.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias LocationErrorType = Swift.Error & Displayable

extension Displayable where Self: Swift.Error {
    var presentable: UIAlertController {
        let alert = UIAlertController(title: self.title,
                                      message: self.message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))

        return alert
    }
}

extension CLError: LocationErrorType {
    var title: String {
        switch self.code {
        case .locationUnknown:
            return NSLocalizedString("Location Unknown", comment: "Location Unknown")
        case .denied:
            return NSLocalizedString("Location Disable",
                                     comment: "Location Disable")
        case .network:
            return NSLocalizedString("Netwwork Error", comment: "Netwwork Error")
        case .geocodeFoundNoResult, .geocodeFoundPartialResult, .geocodeCanceled:
            return NSLocalizedString("Geo Coding Error", comment: "Geo Coding Error")
        case .deferredFailed, .deferredNotUpdatingLocation,
             .deferredAccuracyTooLow, .deferredDistanceFiltered, .deferredCanceled:
            return NSLocalizedString("Deferred Error", comment: "Deferred Error")
        default:
            return NSLocalizedString("Location Error", comment: "Location Error")
        }
    }

    var message: String {
        switch self.code {
        case .denied:
            return NSLocalizedString("Please enable Location Services in the Settings App",
                                     comment: "Please enable Location Services in the Settings App")
        default:
            return self.localizedDescription
        }
    }
}

extension CLAuthorizationStatus: BaseConvertibleType {
    func asBase() -> DeviceLocationPermission {
        switch self {
        case .notDetermined, .restricted, .denied:
            return .notAllowed(DeviceLocationError.failedAuthorization)
        case .authorizedAlways:
            return .always
        case .authorizedWhenInUse:
            return .foreground
        }
    }
}

extension DeviceLocationPermission: CoreLocationRepresentable {
    func asCoreLocation() -> CLAuthorizationStatus {
        switch self {
        case .notAllowed:
            return .denied
        case .foreground:
            return .authorizedWhenInUse
        case .always:
            return .authorizedAlways
        }
    }
}
