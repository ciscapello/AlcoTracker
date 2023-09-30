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
    @Persisted var isCustom: Bool

    convenience init(name: String, image: String, isCustom: Bool) {
        self.init()
        id = UUID().uuidString
        self.name = name
        self.image = image
        self.isCustom = isCustom
    }
}

extension Drink: IdentifiableType {
    var identity: String {
        isInvalidated ? "deleted-object-\(UUID().uuidString)" : id
    }

    typealias Identity = String
}
