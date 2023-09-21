//
//  CalendarViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import UIKit

protocol CalendarViewControllerProtocol: AnyObject {}

final class CalendarViewController: UIViewController, CalendarViewControllerProtocol {
    public var presenter: CalendarPresenterProtocol!

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.background()
    }
}
