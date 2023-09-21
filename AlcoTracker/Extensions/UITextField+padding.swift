//
//  UITextField .swift
//  AlcoTracker
//
//  Created by Владимир on 18.09.2023.
//

import UIKit

extension UITextField {
    func setLeftPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: bounds.size.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func setRightPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: bounds.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
