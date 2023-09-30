//
//  Builder.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createTodayModule(router: RouterProtocol, noteService: NoteServiceProtocol) -> UIViewController
    func createCalendarModule(router: RouterProtocol) -> UIViewController
    func createStatisticsModule(router: RouterProtocol) -> UIViewController
    func createTabBarModule(router: RouterProtocol, noteService: NoteServiceProtocol) -> UITabBarController
    func createOnboardingModule(router: RouterProtocol) -> UIViewController
    func createAddNoteModule(router: RouterProtocol, noteService: NoteServiceProtocol) -> UIViewController
    func createAddDrinkModule(router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createTabBarModule(router: RouterProtocol, noteService: NoteServiceProtocol) -> UITabBarController {
        let tabBar = UITabBarController()
        let mainVC = createTodayModule(router: router, noteService: noteService)
        let calendarVC = createCalendarModule(router: router)
        let statisticsVC = createStatisticsModule(router: router)

        let main = createNav(with: "Сегодня", and: UIImage(systemName: "wineglass"), viewController: mainVC)
        let calendar = createNav(with: "Календарь", and: UIImage(systemName: "calendar"), viewController: calendarVC)
        let statistics = createNav(with: "Статистика", and: UIImage(systemName: "chart.bar"), viewController: statisticsVC)

        tabBar.setViewControllers([main, calendar, statistics], animated: true)
        return tabBar
    }

    func createTodayModule(router: RouterProtocol, noteService: NoteServiceProtocol) -> UIViewController {
        let view = TodayViewController()
        let presenter = TodayPresenter(view: view, router: router, noteService: noteService)

        view.presenter = presenter

        return view
    }

    func createAddDrinkModule(router: RouterProtocol) -> UIViewController {
        let view = AddDrinkViewController()
        let presenter = AddDrinkPresenter(view: view, router: router)

        view.presenter = presenter

        return view
    }

    func createCalendarModule(router _: RouterProtocol) -> UIViewController {
        let view = CalendarViewController()
        let presenter = CalendarPresenter(view: view)

        view.presenter = presenter

        return view
    }

    func createStatisticsModule(router _: RouterProtocol) -> UIViewController {
        let view = StatisticsViewController()
        let presenter = StatisticsPresenter(view: view)

        view.presenter = presenter

        return view
    }

    func createOnboardingModule(router: RouterProtocol) -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter(view: view, router: router)

        view.presenter = presenter

        return view
    }

    public func createAddNoteModule(router: RouterProtocol, noteService: NoteServiceProtocol) -> UIViewController {
        let view = AddNoteViewController()
        let presenter = AddNotePresenter(view: view, router: router, noteService: noteService)

        view.presenter = presenter

        return view
    }

    private func createNav(with title: String, and image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        return nav
    }
}
