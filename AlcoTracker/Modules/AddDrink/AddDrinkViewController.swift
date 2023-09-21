//
//  AddDrinkViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 18.09.2023.
//

import RxSwift
import UIKit

protocol AddDrinkViewControllerProtocol: AnyObject {
    var imageControl: ImageControl { get }
    var nameField: UITextField { get }
}

final class AddDrinkViewController: UIViewController, AddDrinkViewControllerProtocol {
    public var presenter: AddDrinkPresenterProtocol!

    let bag = DisposeBag()

    let screenTitle = UILabel().then {
        $0.text = "Создать свой напиток"
    }

    let nameField = UITextField().then {
        $0.placeholder = "Введите название"
    }

    let imageControlLabel = UILabel()
    var imageControl: ImageControl = DrinkImageControl()
    let button = UIButton()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: R.color.background.name)
        hideKeyboardWhenTappedAround()
        setup()
        binding()
    }

    private func setup() {
        let stack = UIStackView(arrangedSubviews: [screenTitle, nameField, imageControlLabel, imageControl, button]).then {
            $0.axis = .vertical
            $0.spacing = 15
            $0.isLayoutMarginsRelativeArrangement = true
            $0.distribution = .fill
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
            $0.setCustomSpacing(25, after: screenTitle)
            $0.setCustomSpacing(4, after: imageControlLabel)
        }
        view.addSubview(stack)

        imageControlLabel.do {
            $0.text = "Выберите картинку"
            $0.font = UIFont(name: R.font.mulishMedium.name, size: 15)
            $0.textColor = UIColor(named: R.color.mainText.name)
        }

        imageControl.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        screenTitle.do {
            $0.textAlignment = .center
            $0.font = UIFont(name: R.font.mulishBold.name, size: 17)
            $0.textColor = UIColor(named: R.color.mainText.name)
        }

        nameField.do {
            $0.backgroundColor = UIColor(named: R.color.fieldBackground.name)
            $0.layer.cornerRadius = 10
            $0.setLeftPadding(8)
            $0.font = UIFont(name: R.font.mulishRegular.name, size: 16)
            $0.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }

        button.do {
            $0.setTitle("Создать", for: .normal)
            $0.titleLabel?.textColor = UIColor(named: R.color.buttonText.name)
            $0.titleLabel?.font = UIFont(name: R.font.mulishMedium.name, size: 17)
            $0.backgroundColor = UIColor(named: R.color.buttonBackground.name)
            $0.layer.cornerRadius = 10
            $0.snp.makeConstraints { make in
                make.height.equalTo(60)
            }
            $0.animateWhenPressed(disposeBag: bag)
        }

        stack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

    private func binding() {
        nameField.rx.controlEvent([.editingDidBegin]).asObservable().subscribe { [weak self] _ in
            guard let self else { return }
            self.nameField.layer.borderColor = UIColor.black.cgColor
            self.nameField.layer.borderWidth = 1
        }.disposed(by: bag)

        nameField.rx.controlEvent([.editingDidEnd]).asObservable().subscribe { [weak self] _ in
            guard let self else { return }
            self.nameField.layer.borderColor = .none
            self.nameField.layer.borderWidth = 0
        }.disposed(by: bag)

        imageControl.selectedImage.bind(to: presenter.drinkImage).disposed(by: bag)
        nameField.rx.text.orEmpty.bind(to: presenter.drinkName).disposed(by: bag)

        Observable.combineLatest(nameField.rx.text.orEmpty, imageControl.selectedImage).bind { [weak self] name, image in
            guard let self else { return }
            if !name.isEmpty && !image.isEmpty {
                self.button.isEnabled = true
                self.button.alpha = 1
            } else {
                self.button.isEnabled = false
                self.button.alpha = 0.8
            }
        }.disposed(by: bag)

        button.rx.tap.bind { [weak self] in
            guard let self else { return }
            self.presenter.saveButtonDidPressed()
        }.disposed(by: bag)
    }
}
