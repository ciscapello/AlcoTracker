// 
//  MainPresenter.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewControllerProtocol, router: RouterProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewControllerProtocol?
    private var router: RouterProtocol?
    
    init(view: MainViewControllerProtocol, router: RouterProtocol) {
        self.view = view
    }
}
