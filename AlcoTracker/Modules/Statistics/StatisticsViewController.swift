// 
//  StatisticsViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit

protocol StatisticsViewControllerProtocol: AnyObject {
    
}

final class StatisticsViewController: UIViewController, StatisticsViewControllerProtocol {
    
    public var presenter: StatisticsPresenterProtocol!
    
    override public func viewDidLoad() -> () {
        super.viewDidLoad()
        view.backgroundColor = R.color.background()
    }
}
