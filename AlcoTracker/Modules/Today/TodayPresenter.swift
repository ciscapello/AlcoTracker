//
//  TodayPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import Foundation

protocol TodayPresenterProtocol: AnyObject {
    init(view: TodayViewControllerProtocol, router: RouterProtocol)
    func showAddNote()
}

final class TodayPresenter: TodayPresenterProtocol {
    private weak var view: TodayViewControllerProtocol?
    private var router: RouterProtocol?

    init(view: TodayViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func showAddNote() {
        router?.pushAddNoteViewController()
    }
}
