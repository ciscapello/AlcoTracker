//
//  RouterTests.swift
//  AlcoTrackerTests
//
//  Created by Владимир on 04.09.2023.
//

@testable import AlcoTracker
import XCTest

class MockNavigationController: UINavigationController {}

final class RouterTests: XCTestCase {
    var router: RouterProtocol!
    let navigationController = MockNavigationController()
    let builder = AssemblyBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: builder)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() {
        router.isOnboardingShowed = false

        router.initialViewController()
        XCTAssertTrue(!navigationController.viewControllers.isEmpty, "initial view controller is empty")
        XCTAssertTrue(navigationController.viewControllers.first is OnboardingViewControllerProtocol, "onboarding doesn't showed, but onboarding view is'n presented")

        router = nil

        router = Router(navigationController: navigationController, assemblyBuilder: builder)
        router.isOnboardingShowed = true
        router.initialViewController()
        XCTAssertTrue(navigationController.viewControllers.first is UITabBarController, "onboarding showed, but tab bar isn't presented")
    }

    func testShowTabNavigator() {
        router.isOnboardingShowed = false
        router.showTabNavigator()
        XCTAssertTrue(navigationController.viewControllers.last is UITabBarController, "view controller is not tab bar")
    }
}
