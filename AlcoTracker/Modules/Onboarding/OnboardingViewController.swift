//
//  OnboardingViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 03.09.2023.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

protocol OnboardingViewControllerProtocol: AnyObject {}

final class OnboardingViewController: UIViewController, OnboardingViewControllerProtocol {
    public var presenter: OnboardingPresenterProtocol!
    var index = 0

    var pageController: OnboardingPageViewController?
    let button = UIButton(type: .system)

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.background()

        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "Mulish-Bold", size: 16)
        button.tintColor = .white
        button.backgroundColor = .blue
        view.addSubview(button)

        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        button.layer.cornerRadius = 10

        configurePageController()
    }

    private func configurePageController() {
        pageController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        guard let pageController else { return }
        addChild(pageController)
        pageController.didMove(toParent: self)
        view.addSubview(pageController.view)
        pageController.view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }

    @objc func buttonTapped(sender _: UIButton) {
        guard let pageController else { return }

        if pageController.pageControl.currentPage == pageController.pages.count - 1 {
            presenter.buttonDidTapped()
        }

        pageController.goToNextPage(pageControl: pageController.pageControl)
    }
}
