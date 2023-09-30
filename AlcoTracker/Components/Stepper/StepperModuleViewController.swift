//
//  StepperModuleViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 30.09.2023.
//

import RxSwift
import UIKit

protocol StepperModuleViewProtocol: AnyObject, UIView {}

final class StepperModuleView: UIView, StepperModuleViewProtocol {
    public var presenter: StepperModulePresenterProtocol!
    let bag = DisposeBag()

    let decrementButton = UIButton(type: .system)
    let incrementButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        let divider = UIView()
        divider.do {
            $0.backgroundColor = .white
            $0.snp.makeConstraints { make in
                make.width.equalTo(1)
            }
        }

        let stack = UIStackView(arrangedSubviews: [decrementButton, divider, incrementButton])
        addSubview(stack)
        stack.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.backgroundColor = R.color.placeholder()
            $0.snp.makeConstraints { make in
                make.width.height.equalToSuperview()
            }
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            $0.layer.cornerRadius = 8
        }
        decrementButton.do {
            $0.setImage(UIImage(systemName: "minus"), for: .normal)
            $0.tintColor = .white
            $0.rx.tap.subscribe(onNext: { [weak self] in
                guard let self else { return }
                presenter.decrement()
            }).disposed(by: bag)
        }
        incrementButton.do {
            $0.setImage(UIImage(systemName: "plus"), for: .normal)
            $0.tintColor = .white
            $0.rx.tap.subscribe(onNext: { [weak self] in
                guard let self else { return }
                presenter.increment()
            }).disposed(by: bag)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
