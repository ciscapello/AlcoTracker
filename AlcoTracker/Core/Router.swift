//
//  Router.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit

protocol RouterMainProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    var window: UIWindow? { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func showTabNavigator()
    func pushAddNoteViewController()
    func presentAddDrinkViewController()
    func dismissPresentedModal()
    var isOnboardingShowed: Bool { get set }
    var tabBar: UITabBarController? { get set }
    init(assemblyBuilder: AssemblyBuilderProtocol, window: UIWindow?, noteService: NoteServiceProtocol)
    func popViewController()
    func showAlert(title: String, text: String)
}

class Router: RouterProtocol {
    var isOnboardingShowed: Bool
    var assemblyBuilder: AssemblyBuilderProtocol?
    var window: UIWindow?
    var tabBar: UITabBarController?
    var noteService: NoteServiceProtocol?

    required init(assemblyBuilder: AssemblyBuilderProtocol, window: UIWindow?, noteService: NoteServiceProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.window = window
        self.noteService = noteService
        let defaults = UserDefaults.standard
        isOnboardingShowed = defaults.bool(forKey: Constants.shared.userDefaultOnboaringKey)
    }

    func initialViewController() {
        guard let window, let noteService else { return }
        if isOnboardingShowed {
            guard let tabBar = assemblyBuilder?.createTabBarModule(router: self, noteService: noteService) else { return }
            self.tabBar = tabBar
            window.rootViewController = tabBar
            window.makeKeyAndVisible()
        } else {
            guard let viewController = assemblyBuilder?.createOnboardingModule(router: self) else { return }
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }

    func showTabNavigator() {
        guard let noteService else { return }
        guard let tabBar = assemblyBuilder?.createTabBarModule(router: self, noteService: noteService) else { return }
        self.tabBar = tabBar
        guard let window else { print("there's no window"); return }
        window.rootViewController = tabBar
        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }

    func pushAddNoteViewController() {
        guard let tabBar, let noteService else { return }
        guard let navigationController = tabBar.selectedViewController as? UINavigationController else { return }
        guard let addNoteViewController = assemblyBuilder?.createAddNoteModule(router: self, noteService: noteService) else { return }
        navigationController.pushViewController(addNoteViewController, animated: true)
    }

    func presentAddDrinkViewController() {
        guard let tabBar else { return }
        guard let navigationController = tabBar.selectedViewController as? UINavigationController else { return }
        guard let addDrinkViewController = assemblyBuilder?.createAddDrinkModule(router: self) else { return }
        navigationController.present(addDrinkViewController, animated: true)
    }

    func dismissPresentedModal() {
        guard let tabBar else { return }
        guard let navigationController = tabBar.selectedViewController as? UINavigationController else { return }
        navigationController.dismiss(animated: true)
    }

    func popViewController() {
        guard let tabBar else { return }
        guard let navigationController = tabBar.selectedViewController as? UINavigationController else { return }

        navigationController.popToRootViewController(animated: true)
    }

    func showAlert(title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.cancel, handler: { _ in

        }))

        guard let tabBar else { return }
        guard let navigationController = tabBar.selectedViewController as? UINavigationController else { return }

        navigationController.present(alertController, animated: true, completion: nil)
    }
}
