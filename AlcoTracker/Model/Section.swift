//
//  Section.swift
//  AlcoTracker
//
//  Created by Владимир on 22.09.2023.
//

import Foundation
import RxDataSources

struct Section {
    let header: String
    var items: [Drink]
}

extension Section: AnimatableSectionModelType {
    typealias Item = Drink

    var identity: String {
        header
    }

    init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
}

struct NoteSection {
    let header: String
    var items: [Note]
}

extension NoteSection: AnimatableSectionModelType {
    typealias Item = Note

    var identity: String {
        header
    }

    init(original: NoteSection, items: [Item]) {
        self = original
        self.items = items
    }
}
