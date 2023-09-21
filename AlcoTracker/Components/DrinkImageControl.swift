//
//  DrinkImageControl.swift
//  AlcoTracker
//
//  Created by Владимир on 18.09.2023.
//

import RxRelay
import RxSwift
import UIKit

protocol ImageControl: UIView {
    var selectedImage: BehaviorRelay<String> { get }
}

class DrinkImageControl: UIScrollView, ImageControl {
    let stack = UIStackView()

    let bag = DisposeBag()

    let images = Constants.shared.images

    let selectedImage: BehaviorRelay<String> = BehaviorRelay(value: Constants.shared.images.first!)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentSize = CGSize(width: images.count * 70, height: 60)

        stack.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
        }

        for image in images {
            let button = ImageButton()
            button.setImage(UIImage(named: image), for: .normal)
            button.snp.makeConstraints { make in
                make.height.width.equalTo(60)
            }
            button.imageName = image
            button.imageView?.contentMode = .scaleAspectFit
            button.layer.borderColor = UIColor(named: R.color.mainText.name)?.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 7
            button.addTarget(self, action: #selector(imageButtonPressed(sender:)), for: .touchUpInside)
            if image == selectedImage.value {
                button.alpha = 0.5
                button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            stack.addArrangedSubview(button)
        }
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.width.equalTo(images.count * 70)
            make.height.equalTo(60)
        }
        showsHorizontalScrollIndicator = false
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func animateSelected(button: UIButton) {
        UIView.animate(withDuration: 0.2) {
            button.alpha = 0.5
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    private func animateDeselected(button: UIButton) {
        UIView.animate(withDuration: 0.2) {
            button.alpha = 1
            button.transform = .identity
        }
    }

    @objc fileprivate func imageButtonPressed(sender: ImageButton) {
        selectedImage.accept(sender.imageName)

        stack.arrangedSubviews.forEach { button in
            animateDeselected(button: button as! UIButton)
            if sender.imageName == (button as! ImageButton).imageName {
                animateSelected(button: button as! UIButton)
            }
        }
    }
}

private class ImageButton: UIButton {
    var imageName = String()
}
