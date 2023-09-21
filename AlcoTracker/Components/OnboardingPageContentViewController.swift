//
//  OnboardingPageContentViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 03.09.2023.
//

import SnapKit
import UIKit

class OnboardingPageContentViewController: UIViewController {
    var pageTitleLabel = UILabel()
    var pageLabel = UILabel()
    var pageImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        pageLabel.numberOfLines = 0
        pageLabel.font = UIFont(name: "Mulish-Regular", size: 15)
        pageTitleLabel.font = UIFont(name: "Mulish-Bold", size: 18)

        let innerStack = UIStackView(arrangedSubviews: [pageTitleLabel, pageLabel]).then {
            $0.axis = .vertical
            $0.spacing = 10
            $0.alignment = .leading
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        }

        let stack = UIStackView(arrangedSubviews: [pageImage, innerStack])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }

        pageImage.contentMode = .scaleAspectFit
        pageImage.snp.makeConstraints { make in
            make.height.equalTo(pageImage.snp.width)
        }
        pageImage.clipsToBounds = true
    }

    func configure(title: String, label: String, image: String) {
        pageTitleLabel.text = title
        pageLabel.text = label
        pageImage.image = UIImage(named: image)
    }
}
