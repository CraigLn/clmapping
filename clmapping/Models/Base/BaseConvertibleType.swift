//
//  BaseConvertibleType.swift
//  clmapping
//
//  Created by Craig Lane on 1/22/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

protocol BaseConvertibleType {
    associatedtype BaseType

    func asBase() -> BaseType
}
