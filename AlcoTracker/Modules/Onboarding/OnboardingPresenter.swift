// 
//  OnboardingPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 03.09.2023.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    init(view: OnboardingViewControllerProtocol, router: RouterProtocol)
    func buttonDidTapped()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    
    private weak var view: OnboardingViewControllerProtocol?
    private var router: RouterProtocol?
    
    init(view: OnboardingViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func buttonDidTapped() {
        router?.showTabNavigator()
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: userDefaultOnboaringKey)
    }
}
