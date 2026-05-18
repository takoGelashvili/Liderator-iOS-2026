//
//  ViewController.swift
//  UITableView
//
//  Created by Tamar Gelashvili on 18/05/2026.
//

import UIKit

final class ViewController: UIViewController {
    private var months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private var liderators: [String] = ["Liderator Kato", "Liderator Lela", "Liderator Ani", "Liderator Tsotne", "Liderator Luka", "Liderator Mate", "Liderator Givi"]
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //var myDataSource: UITableViewDiffableDataSource<Int, String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: String(describing: CustomCell.self))
        
        tableView.setEditing(true, animated: true)
//        addDataSource()
//        applySnapshot()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController {
//    func addDataSource() {
//        myDataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { [weak self] tableView, indexPath, title in
//            let title = indexPath.isMonthsSection ? self?.months[indexPath.row] : self?.liderators[indexPath.row]
//            let subtitle = indexPath.isMonthsSection ? "Month" : "Liderator"
//            let isHidden = indexPath.row.isMultiple(of: 2)
//            let color = indexPath.row.isMultiple(of: 2) ? UIColor.red: nil
//            
//            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell.self)) as? CustomCell {
//                print("REUSING \(cell.titleLabel.text), NOW SET \(title)")
//                cell.configure(title: title ?? "", subtitle: subtitle, isMoonHidden: isHidden, color: color)
//                return cell
//            }
//            
//            let newCell = CustomCell()
//            newCell.configure(title: title ?? "", subtitle: subtitle, isMoonHidden: isHidden, color: color)
//            return newCell
//        }
//    }
//    
//    func applySnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
//        snapshot.appendSections([0, 1])
//        snapshot.appendItems(months, toSection: 0)
//        snapshot.appendItems(liderators, toSection: 1)
//        myDataSource?.apply(snapshot, animatingDifferences: true)
//    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section.isMonthsSection ? months.count : liderators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let text = indexPath.isMonthsSection ? months[indexPath.row] : liderators[indexPath.row]
//        var configuration = cell.defaultContentConfiguration()
//        configuration.text = text
//        cell.contentConfiguration = configuration
//        return cell
        
        let title = indexPath.isMonthsSection ? months[indexPath.row] : liderators[indexPath.row]
        let subtitle = indexPath.isMonthsSection ? "Month" : "Liderator"
        let isHidden = indexPath.row.isMultiple(of: 2)
        let color = indexPath.row.isMultiple(of: 2) ? UIColor.red: nil
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell.self)) as? CustomCell {
            print("REUSING \(cell.titleLabel.text), NOW SET \(title)")
            cell.configure(title: title, subtitle: subtitle, isMoonHidden: isHidden, color: color)
            return cell
        }
        
        let newCell = CustomCell()
        newCell.configure(title: title, subtitle: subtitle, isMoonHidden: isHidden, color: color)
        return newCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section.isMonthsSection ? "Months" : "Liderators"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .insert
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

extension ViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let image = section.isMonthsSection ? UIImage(systemName: "calendar") : UIImage(systemName: "birthday.cake")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            _ = indexPath.isMonthsSection ? months.remove(at: indexPath.row) : liderators.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            showAlert(addTapHandler: { [weak self] textfieldText in
                _ = indexPath.isMonthsSection
                ? self?.months.insert(textfieldText, at: indexPath.row)
                : self?.liderators.insert(textfieldText, at: indexPath.row)
                tableView.insertRows(at: [indexPath], with: .middle)
            })
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        if sourceIndexPath.isMonthsSection {
            if !destinationIndexPath.isMonthsSection {
                let month = months.remove(at: sourceIndexPath.row)
                liderators.insert(month, at: destinationIndexPath.row)
            }
        } else {
            if destinationIndexPath.isMonthsSection {
                let liderator = liderators.remove(at: sourceIndexPath.row)
                months.insert(liderator, at: destinationIndexPath.row)
            }
        }
    }
}

private extension Int {
    var isMonthsSection: Bool {
        self == 0
    }
}

private extension IndexPath {
    var isMonthsSection: Bool {
        section == 0
    }
}

extension ViewController {
    private func showAlert(addTapHandler: @escaping (String) -> Void) {
        let alertVC = UIAlertController(
            title: "Add row",
            message: "message",
            preferredStyle: .alert
        )
        
        alertVC.addTextField { (textField) in
            textField.placeholder = "Enter"
        }
        
        alertVC.addAction(.init(title: "Cancel", style: .cancel))

        alertVC.addAction(UIAlertAction(
            title: "Add",
            style: .default,
            handler: { _ in
                addTapHandler(alertVC.textFields?.first?.text ?? "")
            })
        )
        
        present(alertVC, animated: true)
    }
}
