//
//  AddDrinkPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 18.09.2023.
//

import Foundation
import RealmSwift
import RxRelay
import RxSwift

protocol AddDrinkPresenterProtocol: AnyObject {
    init(view: AddDrinkViewControllerProtocol, router: RouterProtocol)
    var drinkName: BehaviorRelay<String> { get }
    var drinkImage: BehaviorSubject<String> { get }
    func saveButtonDidPressed()
}

final class AddDrinkPresenter: AddDrinkPresenterProtocol {
    let drinkName = BehaviorRelay(value: "")
    let drinkImage: BehaviorSubject<String> = BehaviorSubject(value: Constants.shared.images.first!)

    let router: RouterProtocol
    let realm = try! Realm()
    let bag = DisposeBag()

    private weak var view: AddDrinkViewControllerProtocol?

    init(view: AddDrinkViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func checkIfDrinkExists(drinkName: String) -> Bool {
        let objects = realm.objects(Drink.self).where { drink in
            drink.name == drinkName
        }
        if objects.isEmpty {
            return false
        } else {
            return true
        }
    }

    func saveButtonDidPressed() {
        let isExists = checkIfDrinkExists(drinkName: drinkName.value)
        if isExists { view?.needShowToast(); return }

        let image = try! drinkImage.value()
        let drink = Drink(name: drinkName.value, image: image, isCustom: true)
        try! realm.write {
            realm.add(drink)
        }
        router.dismissPresentedModal()
    }
}
