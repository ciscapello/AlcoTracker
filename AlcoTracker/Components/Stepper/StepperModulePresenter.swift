//
//  StepperModulePresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 30.09.2023.
//

import Foundation

protocol StepperModulePresenterProtocol: AnyObject {
    init(view: StepperModuleViewProtocol, incrementAction: @escaping () -> Void, decrementAction: @escaping () -> Void)
    var increment: () -> Void? { get }
    var decrement: () -> Void? { get }
}

final class StepperModulePresenter: StepperModulePresenterProtocol {
    private weak var view: StepperModuleViewProtocol?

    var increment: () -> Void?
    var decrement: () -> Void?

    init(view: StepperModuleViewProtocol, incrementAction: @escaping () -> Void, decrementAction: @escaping () -> Void) {
        self.view = view
        increment = incrementAction
        decrement = decrementAction
    }
}
