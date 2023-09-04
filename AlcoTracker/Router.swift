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
    func initialViewController ()
    func showTabNavigator ()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let defaults = UserDefaults.standard
        let isOnboardingShowed = defaults.bool(forKey: userDefaultOnboaringKey)
        guard let navigationController else { return }

        if isOnboardingShowed {
            guard let tabBar = assemblyBuilder?.createTabBarModule(router: self) else { return }
            navigationController.viewControllers = [tabBar]
        } else {
            guard let vc = assemblyBuilder?.createOnboardingModule(router: self) else { return }
            navigationController.viewControllers = [vc]
        }
    }
    
    func showTabNavigator () {
        guard let navigationController else { return }
        guard let tabBar = assemblyBuilder?.createTabBarModule(router: self) else { return }
        navigationController.setViewControllers([tabBar], animated: true)
    }
}
