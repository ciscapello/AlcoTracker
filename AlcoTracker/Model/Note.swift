//
//  Note.swift
//  AlcoTracker
//
//  Created by Владимир on 19.09.2023.
//

import Differentiator
import Foundation
import RealmSwift

class Note: Object {
    @Persisted var id: String
    @Persisted var date: Date
    @Persisted var drink: Drink?
    @Persisted var drinkAmount: Int

    convenience init(drink: Drink? = nil) {
        self.init()
        id = UUID().uuidString
        date = Date()
        self.drink = drink
        drinkAmount = 1
    }
}

extension Note: IdentifiableType {
    var identity: String {
        isInvalidated ? "deleted-object-\(UUID().uuidString)" : "\(id)-\(drinkAmount)"
    }

    typealias Identity = String
}
