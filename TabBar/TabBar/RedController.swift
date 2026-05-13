//
//  RedController.swift
//  TabBar
//
//  Created by Tamar Gelashvili on 13/05/2026.
//

import UIKit

final class RedController: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        print(self.tabBarController!.selectedViewController)
        print(self.tabBarController!.selectedIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.tabBarController?.tabs)
    }
    
    @objc
    private func didTapNextButton() {
        self.navigationController?.pushViewController(BlueController(), animated: true)
    }
}

