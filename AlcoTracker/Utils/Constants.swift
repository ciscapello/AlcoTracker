//
//  Constants.swift
//  AlcoTracker
//
//  Created by Владимир on 04.09.2023.
//

import Foundation

struct Constants {
    static let shared = Constants()

    private init() {}

    let userDefaultOnboaringKey = "isOnboardingShowed"

    let images = [R.image.beerMug.name, R.image.bottle.name, R.image.bottleChampange.name, R.image.bottleWine.name, R.image.cocktail.name, R.image.highball.name, R.image.wineGlass.name]
}
