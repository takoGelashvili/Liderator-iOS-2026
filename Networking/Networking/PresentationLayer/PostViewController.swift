//
//  ViewController.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

import UIKit

protocol PostView: AnyObject {
    func showPosts()
}

final class PostViewController: UITableViewController, PostView {
    var presenter: PostsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        Task {
            await presenter.viewDidLoad()
        }
    }
    
    func showPosts() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = presenter.posts[indexPath.row].title
        cell.contentConfiguration = configuration
        return cell
    }
}

