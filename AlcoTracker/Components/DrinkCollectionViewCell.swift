//
//  DrinkCollectionViewCell.swift
//  AlcoTracker
//
//  Created by Владимир on 15.09.2023.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {
    let image = UIImageView()
    let name = UILabel()

    static let reuseIdentifier = "drinkCell"

    func configureCell(image: String, name: String) {
        self.image.image = UIImage(named: image)
        self.name.text = name
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let stack = UIStackView(arrangedSubviews: [image, name]).then {
            $0.axis = .vertical
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }

        contentView.addSubview(stack)
        contentView.backgroundColor = UIColor(named: R.color.drinkCardBackground.name)
        contentView.layer.cornerRadius = 12

        stack.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }

        image.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        image.contentMode = .scaleAspectFit

        name.font = UIFont(name: R.font.mulishRegular.name, size: 15)
    }

    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func shrink(down: Bool) {
        UIView.animate(withDuration: 0.2) {
            if down {
                self.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.contentView.transform = .identity
            }
        }
    }
}
