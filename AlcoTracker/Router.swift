//
//  Router.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func showTabNavigator()
    func pushAddNoteViewController()
    func presentAddDrinkViewController()
    func dismissPresentedModal()
    var isOnboardingShowed: Bool { get set }
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol)
}

class Router: RouterProtocol {
    var isOnboardingShowed: Bool
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    required init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        let defaults = UserDefaults.standard
        isOnboardingShowed = defaults.bool(forKey: Constants.shared.userDefaultOnboaringKey)
    }

    func initialViewController() {
        guard let navigationController else { return }
        if isOnboardingShowed {
            guard let tabBar = assemblyBuilder?.createTabBarModule(router: self) else { return }
            navigationController.viewControllers = [tabBar]
        } else {
            guard let viewController = assemblyBuilder?.createOnboardingModule(router: self) else { return }
            navigationController.viewControllers = [viewController]
        }
    }

    func showTabNavigator() {
        guard let navigationController else { return }
        guard let tabBar = assemblyBuilder?.createTabBarModule(router: self) else { return }
        navigationController.setViewControllers([tabBar], animated: true)
    }

    func pushAddNoteViewController() {
        guard let navigationController else { return }
        guard let addNoteViewController = assemblyBuilder?.createAddNoteModule(router: self) else { return }
        navigationController.pushViewController(addNoteViewController, animated: true)
    }

    func presentAddDrinkViewController() {
        guard let navigationController else { return }
        guard let addDrinkViewController = assemblyBuilder?.createAddDrinkModule(router: self) else { return }
        navigationController.present(addDrinkViewController, animated: true)
    }

    func dismissPresentedModal() {
        guard let navigationController else { return }
        navigationController.dismiss(animated: true)
    }
}
