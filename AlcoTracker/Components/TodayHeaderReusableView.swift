//
//  TodayHeaderReusableView.swift
//  AlcoTracker
//
//  Created by Владимир on 22.09.2023.
//

import RxSwift
import UIKit

class TodayHeaderReusableView: UICollectionReusableView {
    let button = UIButton()
    let bag = DisposeBag()

    static let identifier = "todayHeaderIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.do {
            $0.setTitle("Добавить напиток", for: .normal)
            $0.backgroundColor = R.color.buttonBackground()
            $0.titleLabel?.textColor = R.color.buttonText()
            $0.layer.cornerRadius = 10
            $0.snp.makeConstraints { make in
                make.width.height.equalToSuperview()
            }
            $0.animateWhenPressed(disposeBag: bag)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
