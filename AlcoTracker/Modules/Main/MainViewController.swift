// 
//  MainViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit
import RswiftResources

protocol MainViewControllerProtocol: AnyObject {
    
}

final class MainViewController: UIViewController, MainViewControllerProtocol {
    
    public var presenter: MainPresenterProtocol!
    
    override public func viewDidLoad() -> () {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: R.color.background.name)
    }
}
