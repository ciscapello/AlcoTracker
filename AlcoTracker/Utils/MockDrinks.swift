//
//  MockDrinks.swift
//  AlcoTracker
//
//  Created by Владимир on 15.09.2023.
//

import Foundation

class MockDrinks {
    static let shared = MockDrinks()

    func returnDrinks() -> [Drink] {
        [Drink(name: "Вино красное", image: R.image.bottleWine.name, isCustom: false),
         Drink(name: "Вино белое", image: R.image.bottleWine.name, isCustom: false),
         Drink(name: "Пиво", image: R.image.beerMug.name, isCustom: false),
         Drink(name: "Коктейль", image: R.image.cocktail.name, isCustom: false)]
    }

    private init() {}
}
