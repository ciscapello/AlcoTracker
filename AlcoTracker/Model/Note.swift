//
//  Note.swift
//  AlcoTracker
//
//  Created by Владимир on 19.09.2023.
//

import Foundation
import RealmSwift

class Note: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var date: Date
    @Persisted var drink: Drink?
    @Persisted var drinkAmount: Int
}
