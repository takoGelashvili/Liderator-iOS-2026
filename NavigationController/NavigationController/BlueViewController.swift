//
//  BlueViewController.swift
//  NavigationController
//
//  Created by Tamar Gelashvili on 08/05/2026.
//

import UIKit

final class BlueViewController: UIViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        print("BLUE", navigationController?.viewControllers)
        print("")
        
        var vcs = self.navigationController?.viewControllers
        
        //vcs?.remove(at: 0)
        //[red, blue] dgaxar lurjze
        //vcs?.insert(GreenViewController(), at: 1) //[red, green, blue]
        
        vcs?.append(GreenViewController())
        vcs?.append(GreenViewController())
        vcs?.append(GreenViewController())
        
        self.navigationController?.setViewControllers(vcs ?? [], animated: true)
        
        // [ViewController, BlueViewController] -> [BlueViewController]
        
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, World!"
        label.textColor = .white
        label.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "Hello, World!"
        label2.textColor = .white
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "Hello, World!"
        label3.textColor = .white
        label3.sizeToFit()
        
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 500
        vStack.alignment = .center
        vStack.distribution = .equalSpacing
        
        view.addSubview(scroll)
        scroll.addSubview(vStack)

        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(label2)
        vStack.addArrangedSubview(label3)
        

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            vStack.topAnchor.constraint(equalTo: scroll.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor)
        ])
    }
}
