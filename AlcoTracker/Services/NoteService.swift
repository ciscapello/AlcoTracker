//
//  NoteService.swift
//  AlcoTracker
//
//  Created by Владимир on 29.09.2023.
//

import Foundation
import RealmSwift

protocol NoteServiceProtocol {
    func addToNotes(drink: Drink)
    func incrementDrinkAmount(note: Note)
    func decrementDrinkAmount(note: Note)
}

class NoteService: NoteServiceProtocol {
    let realm = try! Realm()

    init() {}

    func addToNotes(drink: Drink) {
        let currentDayNotes = notesIncludesDrinkInCurrentDate(drink: drink)
        if currentDayNotes.isEmpty {
            let note = Note(drink: drink)
            try! realm.write {
                realm.add(note)
            }
        } else {
            let note = currentDayNotes.first
            incrementDrinkAmount(note: note!)
        }
    }

    private func notesIncludesDrinkInCurrentDate(drink: Drink) -> [Note] {
        let date = Date()

        let notes = realm.objects(Note.self)
        let currentNotes = notes.where {
            $0.date > date.startDate && $0.date < date.endDate && $0.drink.name == drink.name
        }

        print(currentNotes)

        return currentNotes.toArray()
    }

    func incrementDrinkAmount(note: Note) {
        try! realm.write {
            note.drinkAmount += 1
        }
    }

    func decrementDrinkAmount(note: Note) {
        guard note.drinkAmount > 1 else { return }
        try! realm.write {
            note.drinkAmount -= 1
        }
    }
}
