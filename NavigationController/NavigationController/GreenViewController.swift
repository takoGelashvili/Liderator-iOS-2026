//
//  GreenViewController.swift
//  NavigationController
//
//  Created by Tamar Gelashvili on 08/05/2026.
//

import UIKit

final class GreenViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to roor", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        print("GREEN", navigationController?.viewControllers)
        print("")

        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc
    func didTapButton() {
        //self.navigationController?.pushViewController(RedController(), animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
