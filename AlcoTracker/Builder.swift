//
//  Builder.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createCalendarModule(router: RouterProtocol) -> UIViewController
    func createStatisticsModule(router: RouterProtocol) -> UIViewController
    func createTabBarModule(router: RouterProtocol) -> UITabBarController
    func createOnboardingModule(router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createTabBarModule(router: RouterProtocol) -> UITabBarController {
        let tabBar = UITabBarController()
        let mainVC = createMainModule(router: router)
        let calendarVC = createCalendarModule(router: router)
        let statisticsVC = createStatisticsModule(router: router)
        
        let main = createNav(with: "Главная", and: UIImage(systemName: "house"), viewController: mainVC)
        let calendar = createNav(with: "Календарь", and: UIImage(systemName: "calendar"), viewController: calendarVC)
        let statistics = createNav(with: "Статистика", and: UIImage(systemName: "chart.bar"), viewController: statisticsVC)
        
        tabBar.setViewControllers([main, calendar, statistics], animated: true)
        return tabBar
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func createCalendarModule(router: RouterProtocol) -> UIViewController {
        let view = CalendarViewController()
        let presenter = CalendarPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    func createStatisticsModule(router: RouterProtocol) -> UIViewController {
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

    
    private func createNav (with title: String, and image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
                
        return nav
    }
}
