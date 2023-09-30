//
//  AddNoteViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 07.09.2023.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

protocol AddNoteViewControllerProtocol: AnyObject {}

final class AddNoteViewController: UIViewController, AddNoteViewControllerProtocol, UIScrollViewDelegate {
    public var presenter: AddNotePresenterProtocol!

    let collectionView = UICollectionView(frame: .null, collectionViewLayout: UICollectionViewFlowLayout())

    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>?
    let bag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: R.color.background.name)
        title = "Добавить напиток"

        setupCollectionView()
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.right.left.bottom.top.equalToSuperview()
        }
        collectionView.register(DrinkCollectionViewCell.self, forCellWithReuseIdentifier: DrinkCollectionViewCell.reuseIdentifier)
        collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.identifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.delaysContentTouches = false

        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(configureCell: { _, collectionView, indexPath, item in
            // cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.reuseIdentifier, for: indexPath) as! DrinkCollectionViewCell
            cell.configureCell(image: item.image, name: item.name)
            return cell
        }, configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath in
            // Supplementary view
            guard let self else { return UICollectionReusableView() }

            let section = dataSource.sectionModels[indexPath.section]

            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.identifier, for: indexPath) as! SectionHeader
            sectionHeader.setup(title: section.header, forCustomSection: indexPath.section == 0)
            sectionHeader.button.rx.tap.bind { [weak self] in
                guard let self else { return }
                onHeaderButtonPress()
            }.disposed(by: bag)

            return sectionHeader
        })

        self.dataSource = dataSource

        collectionView.rx.modelSelected(Drink.self).subscribe { [weak self] event in
            guard let drink = event.element, let self else { return }
            presenter.itemDidSelected(with: drink)
        }.disposed(by: bag)

        presenter.sections.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: bag)
        collectionView.rx.setDelegate(self).disposed(by: bag)
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let header = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func createSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }

    func onHeaderButtonPress() {
        presenter.headerButtonDidPressed()
    }
}

extension AddNoteViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point _: CGPoint) -> UIContextMenuConfiguration? {
        if indexPaths.isEmpty { return nil }
        guard let section = indexPaths.first?.first else { return nil }
        if section > 0 { return nil }

        let deleteCancel = UIAction(title: "Отмена", image: UIImage(systemName: "xmark")) { _ in }
        let deleteConfirmation = UIAction(title: "Да, удалить", image: UIImage(systemName: "checkmark"), attributes: .destructive) { [weak self] _ in
            guard let self else { return }
            presenter.onDeleteDrinkItemByIndexPath(indexPaths.first!)
        }
        let delete = UIMenu(title: "Удалить", image: UIImage(systemName: "trash"), options: .destructive, children: [deleteCancel, deleteConfirmation])
        let mainMenu = UIMenu(title: "", children: [delete])

        return UIContextMenuConfiguration(actionProvider: { _ in
            mainMenu
        })
    }
}
