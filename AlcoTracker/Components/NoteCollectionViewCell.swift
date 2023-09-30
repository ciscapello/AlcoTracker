//
//  NoteCollectionViewCell.swift
//  AlcoTracker
//
//  Created by Владимир on 22.09.2023.
//

import RxSwift
import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    let drinkNameLabel = UILabel()
    var stepper: StepperModuleViewProtocol?
    let amountLabel = UILabel()
    let image = UIImageView()
    var note: Note?
    var noteService: NoteServiceProtocol?

    let bag = DisposeBag()
    static let identifier = "noteCellIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        stepper = StepperModuleBuilder.build(incrementAction: {
            self.increaseAmount()
        }, decrementAction: {
            self.decreaseAmount()
        })
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        guard let stepper else { return }
        let innerStack = UIStackView(arrangedSubviews: [amountLabel, stepper])
        innerStack.do {
            $0.axis = .vertical
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        }

        image.do {
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            image.contentMode = .scaleAspectFit
        }

        let stack = UIStackView(arrangedSubviews: [image, drinkNameLabel, innerStack])
        contentView.addSubview(stack)

        drinkNameLabel.do {
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.font = R.font.mulishMedium(size: 17)
        }

        amountLabel.do {
            $0.font = R.font.mulishBold(size: 17)
        }

        stack.do {
            $0.backgroundColor = R.color.drinkCardBackground()
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.isLayoutMarginsRelativeArrangement = false
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            $0.snp.makeConstraints { make in
                make.width.height.equalToSuperview()
            }
            $0.layer.cornerRadius = 10
        }
    }

    func configureCell(drinkName: String, amount: Int, image: String, note: Note, noteService: NoteServiceProtocol) {
        drinkNameLabel.text = drinkName
        amountLabel.text = String(amount)
        self.image.image = UIImage(named: image)
        self.note = note
        self.noteService = noteService
    }

    private func decreaseAmount() {
        print("Decrease")
        guard let note, let noteService else { return }
        noteService.decrementDrinkAmount(note: note)
    }

    private func increaseAmount() {
        print("Increase")
        guard let note, let noteService else { return }
        noteService.incrementDrinkAmount(note: note)
    }
}
