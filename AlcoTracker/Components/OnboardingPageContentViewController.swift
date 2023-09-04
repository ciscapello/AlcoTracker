//
//  OnboardingPageContetntViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 03.09.2023.
//

import UIKit
import SnapKit

class OnboardingPageContentViewController: UIViewController {
    
    var pageTitleLabel = UILabel()
    var pageLabel = UILabel()
    var pageImage = UIImageView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        pageLabel.numberOfLines = 0
        pageLabel.font = UIFont(name: "Mulish-Regular", size: 15)
        pageTitleLabel.font = UIFont(name: "Mulish-Bold", size: 18)
        
        let innerStack = UIStackView(arrangedSubviews: [pageTitleLabel, pageLabel])
        innerStack.axis = .vertical
        innerStack.spacing = 10
        innerStack.alignment = .leading
        innerStack.isLayoutMarginsRelativeArrangement = true
        innerStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
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
        self.pageTitleLabel.text = title
        self.pageLabel.text = label
        self.pageImage.image = UIImage(named: image)
    }

}
