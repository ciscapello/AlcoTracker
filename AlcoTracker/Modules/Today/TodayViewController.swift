//
//  TodayViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import RswiftResources
import RxSwift
import UIKit

protocol TodayViewControllerProtocol: AnyObject {}

final class TodayViewController: UIViewController, TodayViewControllerProtocol {
    public var presenter: TodayPresenterProtocol!

    let disposeBag = DisposeBag()

    let button = UIButton(type: .custom)

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: R.color.background.name)
        setupButton()
    }

    override func viewWillAppear(_: Bool) {
        button.startPulse()
    }

    override func viewDidLayoutSubviews() {
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.animateWhenPressed(disposeBag: disposeBag)
    }

    func setupButton() {
        view.addSubview(button)
        button.setTitle("Я пью", for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        button.backgroundColor = UIColor(named: "mainButton")
        button.titleLabel?.font = UIFont(name: "Mulish-Medium", size: 24)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }

    @objc func buttonPressed(sender _: UIButton) {
        presenter.showAddNote()
    }
}
