//
//  CalendarPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import Foundation

protocol CalendarPresenterProtocol: AnyObject {
    init(view: CalendarViewControllerProtocol)
}

final class CalendarPresenter: CalendarPresenterProtocol {
    private weak var view: CalendarViewControllerProtocol?

    init(view: CalendarViewControllerProtocol) {
        self.view = view
    }
}
