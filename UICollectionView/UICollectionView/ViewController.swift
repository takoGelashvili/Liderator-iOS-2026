//
//  ViewController.swift
//  UICollectionView
//
//  Created by Tamar Gelashvili on 20/05/2026.
//

import UIKit

class ViewController: UICollectionViewController {
    
    struct Item {
        let title: String
        let color: UIColor
    }
    
    let items: [Item] = [
        .init(title: "Red", color: .red),
        .init(title: "Green", color: .green),
        .init(title: "Blue", color: .blue),
        .init(title: "Yellow", color: .yellow),
        .init(title: "Orange", color: .orange),
        .init(title: "Purple", color: .purple),
        .init(title: "Pink", color: .systemPink)
    ]
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Colors"
        collectionView.dataSource = self
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.reuseId)
        collectionView.backgroundColor = .cyan
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "2 Columns",
            style: .plain,
            target: self,
            action: #selector(handleButtonTap)
        )
    }
    
    var isTwoCols: Bool = true
    
    @objc
    func handleButtonTap() {
        isTwoCols.toggle()
        
        if isTwoCols {
            navigationItem.rightBarButtonItem?.title = "2 Columns"
        } else {
            navigationItem.rightBarButtonItem?.title = "3 Column"
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: DataSource
extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyCell.reuseId,
            for: indexPath
        ) as! MyCell
        
        let item = items[indexPath.row]
        
        cell.configure(title: item.title, color: item.color, shouldRound: true)
        return cell
    }
}

// MARK: Delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCols = isTwoCols ? 2 : 3
        let width = collectionView.bounds.width / CGFloat(numCols) - 30
        let height = width / 2
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        moveItemAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CompositionalLayout()
        vc.setColor(color: items[indexPath.row].color)
        navigationController?.pushViewController(vc, animated: true)
    }
}

final class MyCell: UICollectionViewCell {
    static let reuseId: String = "ყ"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, color: UIColor, shouldRound: Bool) {
        titleLabel.text = title
        contentView.backgroundColor = color
        
        if shouldRound {
            contentView.layer.cornerRadius = 10
        }
    }
}

//#Preview {
//    ViewController()
//}
