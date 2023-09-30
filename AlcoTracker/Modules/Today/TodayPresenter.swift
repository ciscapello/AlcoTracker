//
//  TodayPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import Foundation
import RealmSwift
import RxRealm
import RxRelay
import RxSwift
import SwiftDate

protocol TodayPresenterProtocol: AnyObject {
    init(view: TodayViewControllerProtocol, router: RouterProtocol, noteService: NoteServiceProtocol)
    func showAddNote()
    var sections: BehaviorRelay<[NoteSection]> { get }
    var noteService: NoteServiceProtocol { get }
}

final class TodayPresenter: TodayPresenterProtocol {
    private weak var view: TodayViewControllerProtocol?
    private var router: RouterProtocol?
    var noteService: NoteServiceProtocol

    let bag = DisposeBag()
    let realm = try! Realm()

    var sections = BehaviorRelay<[NoteSection]>(value: [])

    init(view: TodayViewControllerProtocol, router: RouterProtocol, noteService: NoteServiceProtocol) {
        self.view = view
        self.router = router
        self.noteService = noteService
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        let notes = realm.objects(Note.self).where { note in
            note.date > Date().startDate && note.date < Date().endDate
        }

        Observable.array(from: notes).map { res in
            self.sections.accept([NoteSection(header: "", items: res)])
        }.subscribe { event in
            print(event)
        }.disposed(by: bag)
    }

    func showAddNote() {
        router?.pushAddNoteViewController()
    }
}
