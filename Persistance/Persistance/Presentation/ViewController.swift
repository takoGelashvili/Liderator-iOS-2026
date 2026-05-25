//
//  ViewController.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func reload()
}

final class ViewController: UITableViewController {
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UITableViewCell.self, forCellReuseIdentifier: "CELL"
        )
        presenter.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNote)
        )
    }
    
    @objc
    func addNote() {
        let alert = UIAlertController(
            title: "Add note",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField { textfield in
            textfield.placeholder = "Enter note"
        }
        
        alert.addAction(UIAlertAction(
            title: "Save",
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.addNote(
                    with: alert.textFields?.first?.text ?? "WRONG TITLE"
                )
            })
        )
        
        present(alert, animated: true)
    }
}

extension ViewController: ViewProtocol {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.notes.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CELL",
            for: indexPath
        )
        
        var conf = cell.defaultContentConfiguration()
        conf.text = presenter.notes[indexPath.row].title
        cell.contentConfiguration = conf
        return cell
    }
}

extension ViewController {
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            presenter.deleteNote(at: indexPath.row)
        }
    }
    
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(
            title: "Edit note",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField { textfield in
            textfield.placeholder = "New title"
        }
        
        alert.addAction(UIAlertAction(
            title: "Save",
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.updateNote(
                    at: indexPath.row,
                    with: alert.textFields?.first?.text ?? "WRONG TITLE"
                )
            })
        )
        
        present(alert, animated: true)
    }
}
