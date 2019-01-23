//
//  CoreLocationRepresentable.swift
//  clmapping
//
//  Created by Craig Lane on 1/22/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Contacts

protocol CoreLocationRepresentable {
    associatedtype CoreLocationType: BaseConvertibleType

    func asCoreLocation() -> CoreLocationType
}
