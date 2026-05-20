//
//  CompositionalLayout.swift
//  UICollectionView
//
//  Created by Tamar Gelashvili on 20/05/2026.
//

import UIKit

final class CompositionalLayout: UICollectionViewController {
    
    struct Item {
        let title: String
        let color: UIColor
    }
    
    let items: [Item] = [
        .init(title: "Red", color: .red),
        .init(title: "Green", color: .green),
        .init(title: "Blue", color: .blue),
        .init(title: "Purple", color: .purple),
        .init(title: "Pink", color: .systemPink)
    ]
    
    init() {
        super.init(collectionViewLayout: Self.makeLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.reuseId)
    }
    
    func setColor(color: UIColor) {
        collectionView.backgroundColor = color
    }
    
    static func makeLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            switch sectionIndex {
            case .zero:
                return makeSquaresSection()
            default:
                return makeHorizontalScrollSection()
            }
        })
    }
    
    static func makeSquaresSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let twoItemStack = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1/2)
            ),
            repeatingSubitem: item,
            count: 2
        )
        
        let threeItemStack = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1/3)
            ),
            repeatingSubitem: item,
            count: 3
        )
        
        let mainGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.6)
            ),
            subitems: [
                twoItemStack,
                threeItemStack
            ]
        )
        
        return NSCollectionLayoutSection(group: mainGroup)
    }
    
    static func makeHorizontalScrollSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
        
        let hStack = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.86),
                heightDimension: .fractionalHeight(0.3)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: hStack)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [] // header/footer
        return section
    }
}

extension CompositionalLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyCell.reuseId,
            for: indexPath
        ) as! MyCell
        
        let item = items[indexPath.row]
        
        print("REUSED FROM", cell.titleLabel.text, "NOW SET", item.title)
        
        cell.configure(title: item.title, color: item.color, shouldRound: indexPath.section != 0)
        
        let single = UITapGestureRecognizer(target: self, action: #selector(didTapOnce))
        let double = UITapGestureRecognizer(target: self, action: #selector(didTapTwice))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))

        double.numberOfTapsRequired = 2
        
        single.require(toFail: double)
        
        cell.addGestureRecognizer(single)
        cell.addGestureRecognizer(double)
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    @objc
    private func didTapOnce() {
        print("TAPPED ONCE")
    }
    
    @objc
    private func didTapTwice() {
        print("TAPPED TWICE")
    }
    
    @objc
    private func didLongPress() {
        let actionSheet = MyActionSheet()
        if let sheet = actionSheet.sheetPresentationController {
            let small = UISheetPresentationController.Detent.custom(
                identifier: .init("small"),
                resolver: { context in
                    context.maximumDetentValue * 0.3
                }
            )
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
            sheet.detents = [.large(), .medium(), small]
            sheet.selectedDetentIdentifier = .init("small")
        }
        present(actionSheet, animated: true)
    }
}

extension CompositionalLayout: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(
        _ sheetPresentationController: UISheetPresentationController
    ) {
        print("ACTION SHEET HEIGHT CHANGED")
    }
}

final class MyActionSheet: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
