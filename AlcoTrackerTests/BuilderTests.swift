//
//  BuilderTests.swift
//  AlcoTrackerTests
//
//  Created by Владимир on 05.09.2023.
//

@testable import AlcoTracker
import XCTest

class MockRouter: RouterProtocol {
    func initialViewController() {}
    func showTabNavigator() {}
    var isOnboardingShowed: Bool
    var navigationController: UINavigationController?
    var assemblyBuilder: AlcoTracker.AssemblyBuilderProtocol?

    required init(navigationController: UINavigationController, assemblyBuilder: AlcoTracker.AssemblyBuilderProtocol) {
        isOnboardingShowed = true
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
}

final class BuilderTests: XCTestCase {
    var builder: AssemblyBuilder!
    var router: MockRouter!

    override func setUpWithError() throws {
        builder = AssemblyBuilder()
        router = MockRouter(navigationController: MockNavigationController(), assemblyBuilder: builder)
    }

    override func tearDownWithError() throws {
        builder = nil
    }

    func testCreateTabBarModule() {
        let module = builder.createTabBarModule(router: router)
        XCTAssertTrue(module.viewControllers?.count == 3)
        XCTAssertNotNil(module)
    }

    func testCreateTodayModule() {
        let module = builder.createTodayModule(router: router)
        XCTAssertTrue(module is TodayViewControllerProtocol)
        XCTAssertNotNil(module)
    }

    func testCreateCalendarModule() {
        let module = builder.createCalendarModule(router: router)
        XCTAssertTrue(module is CalendarViewControllerProtocol)
        XCTAssertNotNil(module)
    }

    func testCreateStatisticsModule() {
        let module = builder.createStatisticsModule(router: router)
        XCTAssertTrue(module is StatisticsViewControllerProtocol)
        XCTAssertNotNil(module)
    }

    func testCreateOnboardingModule() {
        let module = builder.createOnboardingModule(router: router)
        XCTAssertTrue(module is OnboardingViewControllerProtocol)
        XCTAssertNotNil(module)
    }
}
