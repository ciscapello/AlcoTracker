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
        return [Drink(name: "Вино красное", image: R.image.bottleWine.name),
                Drink(name: "Вино белое", image: R.image.bottleWine.name),
                Drink(name: "Пиво", image: R.image.beerMug.name),
                Drink(name: "Коктейль", image: R.image.cocktail.name)]
    }

    private init() {}
}
