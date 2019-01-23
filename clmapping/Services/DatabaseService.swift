//
//  DatastoreService.swift
//  clmapping
//
//  Created by Craig Lane on 1/23/19.
//  Copyright © 2019 CraigLn. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


protocol LocationDatabase {
    func store(location: Location)
    func fetchAllLocations()
    func remove(location: Location)
}

struct DatabaseProvider<T: RealmRepresentable> where T == T.RealmType.BaseType, T.RealmType: Object {

    var configuration: Realm.Configuration

    var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    init(config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.configuration = config
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }

    private func fetchAllObjects() -> [T.RealmType] {
        return realm.objects(T.RealmType.self).map { $0 }
    }

    func fetchAll() -> [T] {
        return realm.objects(T.RealmType.self).compactMap { $0.asBase() }
    }

    func fetchLatest() -> T? {
        return realm.objects(T.RealmType.self).last?.asBase()
    }

    func fetch(using predicate: NSPredicate) -> [T] {
        return realm.objects(T.RealmType.self).filter(predicate).compactMap { $0.asBase() }
    }

    func store(_ object: T) {
        try! realm.write {
            realm.add(object.asRealm(), update: true)
        }
    }

    func remove(_ object: T) {
        try! realm.write {
            realm.delete(object.asRealm())
        }
    }

    func removeAllLocations() {
        try! realm.write {
            realm.delete(self.fetchAllObjects())
        }
    }
}

extension DatabaseProvider where T == Location {
    var coordinateMatchPredicateString: String {
        return "latitude > %lf AND latitude < %lf AND longitude > %lf AND longitude < %lf"
    }
}

extension DatabaseProvider where T == Placemark {
    var coordinateMatchPredicateString: String {
        return "location.latitude > %lf AND location.latitude < %lf AND location.longitude > %lf AND location.longitude < %lf"
    }
}


struct DatabaseService {
    var locationProvider: DatabaseProvider<Location>
    var placemarkProvider: DatabaseProvider<Placemark>

    init(locationProvider: DatabaseProvider<Location>, placemarkProvider: DatabaseProvider<Placemark>) {
        self.locationProvider = locationProvider
        self.placemarkProvider = placemarkProvider
    }

    fileprivate func locationMatchPredicate(for location: Location, with formatString: String) -> NSPredicate {
        let epsilon = 0.001
        let long = location.longitude
        let lat = location.latitude


        let predicate = NSPredicate(format: formatString, lat - epsilon, lat + epsilon, long - epsilon, long + epsilon)

        return predicate
    }

    func fetchAllLocations() -> [Location] {
        return self.locationProvider.fetchAll()
    }

    func fetchPlacemark(for location: Location) -> [Placemark] {
        let predicate = locationMatchPredicate(for: location,
                                               with: placemarkProvider.coordinateMatchPredicateString)

        return self.placemarkProvider.fetch(using: predicate)
    }

    func fetchPlacemark() -> Placemark? {
        return placemarkProvider.fetchLatest()
    }

    func storeLocations(locations: [Location]) {
        for location in locations {
            let predicate = locationMatchPredicate(for: location,
                                                   with: locationProvider.coordinateMatchPredicateString)

            if locationProvider.fetch(using: predicate).first == nil {
                locationProvider.store(location)
            }
        }
    }

    func storePlacemark(placemark: Placemark) {

        // Verify placemark doesn't already exist
        guard let location = placemark.location,
            fetchPlacemark(for: location).first == nil else {
            return
        }

        // Verify if placemark.location already exists; use that one if it does
        let predicate = locationMatchPredicate(for: location,
                                               with: locationProvider.coordinateMatchPredicateString)
        if let existingLocation = self.locationProvider.fetch(using: predicate).first {
            placemarkProvider.store(Placemark(placemark: placemark, with: existingLocation))
        } else {
            placemarkProvider.store(placemark)
        }
    }
}
