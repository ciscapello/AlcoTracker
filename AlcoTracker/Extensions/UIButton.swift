//
//  UIButton.swift
//  AlcoTracker
//
//  Created by Владимир on 05.09.2023.
//

import RxCocoa
import RxSwift
import UIKit

extension UIButton {
    func startPulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.fromValue = 1.0
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 1

        layer.add(pulse, forKey: "pulse")
    }

    func animateWhenPressed(disposeBag: DisposeBag) {
        let pressDownTransform = rx.controlEvent([.touchDown, .touchDragEnter])
            .map { 0.7 }

        let pressUpTransform = rx.controlEvent([.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
            .map { 1.0 }

        Observable.merge(pressDownTransform, pressUpTransform)
            .distinctUntilChanged()
            .subscribe(onNext: {
                self.animate($0)
            })
            .disposed(by: disposeBag)
    }

    private func animate(_ alpha: Double) {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [.curveEaseInOut],
            animations: {
                self.alpha = alpha
            },
            completion: nil
        )
    }
}
