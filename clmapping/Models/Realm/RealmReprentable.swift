//
//  RealmRepresentable.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: BaseConvertibleType

    func asRealm() -> RealmType
}
