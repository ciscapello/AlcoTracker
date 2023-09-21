//
//  Drink.swift
//  AlcoTracker
//
//  Created by Владимир on 10.09.2023.
//

import Differentiator
import Foundation
import RealmSwift

class Drink: Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var image: String

    convenience init(name: String, image: String) {
        self.init()
        id = UUID().uuidString
        self.name = name
        self.image = image
    }
}

extension Drink: IdentifiableType {
    var identity: String {
        return isInvalidated ? "deleted-object-\(UUID().uuidString)" : id
    }

    typealias Identity = String
}
