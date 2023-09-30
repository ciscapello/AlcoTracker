//
//  StepperModuleBuilder.swift
//  AlcoTracker
//
//  Created by Владимир on 30.09.2023.
//

import UIKit

final class StepperModuleBuilder {
    public static func build(incrementAction: @escaping () -> Void, decrementAction: @escaping () -> Void) -> StepperModuleView {
        let view = StepperModuleView()
        let presenter = StepperModulePresenter(view: view, incrementAction: incrementAction, decrementAction: decrementAction)

        view.presenter = presenter

        return view
    }
}
