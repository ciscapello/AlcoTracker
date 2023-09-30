//
//  TodayViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 02.09.2023.
//

import RswiftResources
import RxDataSources
import RxSwift
import UIKit

protocol TodayViewControllerProtocol: AnyObject {}

final class TodayViewController: UIViewController, TodayViewControllerProtocol {
    public var presenter: TodayPresenterProtocol!
    let bag = DisposeBag()

    let button = UIButton(type: .custom)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var dataSource: RxCollectionViewSectionedAnimatedDataSource<NoteSection>?

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: R.color.background.name)
        setupButton()
        setupCollectionView()
        title = "Сегодня"

        presenter.sections.subscribe { [weak self] event in
            guard let self else { return }
            guard let sections = event.element else { return }
            if sections.isEmpty { return }
            if !sections.first!.items.isEmpty {
                button.isHidden = true
                collectionView.isHidden = false
            } else {
                button.isHidden = false
                collectionView.isHidden = true
            }
        }.disposed(by: bag)
    }

    override func viewWillAppear(_: Bool) {
        button.startPulse()
    }

    override func viewDidLayoutSubviews() {
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.animateWhenPressed(disposeBag: bag)
    }

    func setupButton() {
        view.addSubview(button)
        button.setTitle("Я пью", for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        button.backgroundColor = R.color.mainButton()
        button.titleLabel?.font = R.font.mulishMedium(size: 24)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }

    @objc func buttonPressed(sender _: UIButton) {
        print("here")
        presenter.showAddNote()
    }
}

// MARK: - Collection View Setup

extension TodayViewController {
    func setupCollectionView() {
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        collectionView.register(TodayHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodayHeaderReusableView.identifier)
        view.addSubview(collectionView)
        collectionView.isHidden = true
        collectionView.snp.makeConstraints { make in
            make.right.left.bottom.top.equalToSuperview()
        }
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.delaysContentTouches = false

        let dataSource = RxCollectionViewSectionedAnimatedDataSource<NoteSection>(configureCell: { [weak self] _, collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as! NoteCollectionViewCell
            cell.configureCell(drinkName: item.drink?.name ?? "", amount: item.drinkAmount, image: item.drink!.image, note: item, noteService: presenter.noteService)
            return cell
        }, configureSupplementaryView: { [weak self] _, collectionView, _, indexPath in
            // Supplementary view
            guard let self else { return UICollectionReusableView() }

            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodayHeaderReusableView.identifier, for: indexPath) as! TodayHeaderReusableView

            sectionHeader.button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)

            sectionHeader.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(10)
                make.width.equalToSuperview().offset(-20)
                make.height.equalTo(50)
            }

            return sectionHeader
        })

        self.dataSource = dataSource

        presenter.sections.debug().bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: bag)
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.boundarySupplementaryItems = [createSectionHeaderLayout()]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func createSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
}
