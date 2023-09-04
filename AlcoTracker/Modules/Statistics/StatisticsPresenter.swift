// 
//  StatisticsPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import Foundation

protocol StatisticsPresenterProtocol: AnyObject {
    init(view: StatisticsViewControllerProtocol)
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    private weak var view: StatisticsViewControllerProtocol?
    
    init(view: StatisticsViewControllerProtocol) {
        self.view = view
    }
}
