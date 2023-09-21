//
//  SectionHeaderReusableView.swift
//  AlcoTracker
//
//  Created by Владимир on 17.09.2023.
//

import RxSwift
import Then
import UIKit

protocol SectionHeader: UICollectionReusableView {
    var title: UILabel { get }
    static var identifier: String { get }
    var button: UIButton { get }
    func setup(title: String, forCustomSection: Bool)
}

class SectionHeaderReusableView: UICollectionReusableView, SectionHeader {
    static let identifier = "sectionHeader"

    let disposeBag = DisposeBag()

    let title = UILabel()
    let button = UIButton()
    let stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 6
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String, forCustomSection _: Bool) {
        addSubview(stack)
        stack.addArrangedSubview(self.title)
        stack.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        stack.do {
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        }

        self.title.do {
            $0.text = title
            $0.font = UIFont(name: R.font.mulishBold.name, size: 17)
            $0.textColor = UIColor(named: R.color.mainText.name)
        }

        if title == "Ваши напитки" {
            setupButton()
        }
    }

    func setupButton() {
        stack.addArrangedSubview(button)
        button.do {
            $0.setTitle("Добавить свой напиток", for: .normal)
            $0.titleLabel?.font = UIFont(name: R.font.mulishMedium.name, size: 17)
            $0.backgroundColor = UIColor(named: R.color.buttonBackground.name)
            $0.tintColor = UIColor(named: R.color.buttonText.name)
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            $0.layer.cornerRadius = 10
            $0.animateWhenPressed(disposeBag: disposeBag)
        }
    }
}
