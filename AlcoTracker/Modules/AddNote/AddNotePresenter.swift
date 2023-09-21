//
//  AddNotePresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 07.09.2023.
//

import Foundation
import RealmSwift
import RxCocoa
import RxRealm
import RxRelay
import RxSwift

protocol AddNotePresenterProtocol: AnyObject {
    init(view: AddNoteViewControllerProtocol, router: RouterProtocol)
    var sections: Observable<[Section]> { get }
    func headerButtonDidPressed()
    func onDeleteDrinkItemByIndexPath(_ indexPath: IndexPath)
}

final class AddNotePresenter: AddNotePresenterProtocol {
    private weak var view: AddNoteViewControllerProtocol?

    let bag = DisposeBag()

    var router: RouterProtocol

    let realm = try! Realm()

    private var currentDrinkValues: [Drink] = []

    var sections: Observable<[Section]> {
        Observable.array(from: realm.objects(Drink.self)).map { results in
            let customDrinks = results
            let originalDrinks = MockDrinks.shared.returnDrinks()
            self.currentDrinkValues = customDrinks
            return [Section(header: "Ваши напитки", items: customDrinks), Section(header: "Выбрать из списка", items: originalDrinks)]
        }
    }

    init(view: AddNoteViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func headerButtonDidPressed() {
        router.presentAddDrinkViewController()
    }

    func onDeleteDrinkItemByIndexPath(_ indexPath: IndexPath) {
        let drinkId = currentDrinkValues[indexPath.row].id
        let drink = realm.objects(Drink.self).where { drink in
            drink.id == drinkId
        }.first
        guard let drink else { return }
        try! realm.write {
            realm.delete(drink)
        }
    }
}
