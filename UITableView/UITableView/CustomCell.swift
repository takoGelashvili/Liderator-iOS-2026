//
//  CustomCell.swift
//  UITableView
//
//  Created by Tamar Gelashvili on 18/05/2026.
//

import UIKit

final class CustomCell: UITableViewCell {
    private let hStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .center
        s.distribution = .fill
        s.spacing = 10
        return s
    }()
    
    private let vStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.alignment = .center
        s.distribution = .fill
        s.spacing = 5
        return s
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let imageV: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "moon.stars.fill"))
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    private let chevron: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "chevron.right"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell {
    private func setupViews() {
        contentView.addSubview(hStack)
        
        accessoryView = chevron
        //accessoryType = .disclosureIndicator
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(imageV)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            imageV.widthAnchor.constraint(equalToConstant: 50),
            imageV.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension CustomCell {
    func configure(title: String, subtitle: String, isMoonHidden: Bool, color: UIColor?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        
        // MARK: BUG
        //        if let color {
        //            titleLabel.textColor = color
        //            subtitleLabel.textColor = color
        //        }
        //
        //        if isMoonHidden {
        //            imageV.isHidden = true
        //        }
        
        if let color {
            titleLabel.textColor = color
            subtitleLabel.textColor = color
        } else {
            titleLabel.textColor = .black
            subtitleLabel.textColor = .black
        }
        
        imageV.isHidden = isMoonHidden
    }
}
