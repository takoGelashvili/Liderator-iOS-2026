//
//  CustomNavigationController.swift
//  NavigationController
//
//  Created by Tamar Gelashvili on 08/05/2026.
//

import UIKit

final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    private var isHeartFilled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    // იძახება ყველა ჯერზე როცა გეცვლება ტოპ vc (push/pop/set)
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        let customBackButton = UIBarButtonItem()
        customBackButton.title = "Back"
        customBackButton.target = self
        customBackButton.action = #selector(didTapBackButton)
        
        let heartButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapHeart)
        )
        
        viewController.navigationItem.rightBarButtonItems = [customBackButton, heartButton]
    }
    
    @objc
    func didTapBackButton() {
        // [ViewController, SecondViewController] -> [ViewController]
        popViewController(animated: false)
    }
    
    @objc
    func didTapHeart(_ sender: UIImageView) {
        isHeartFilled.toggle()

        let image = isHeartFilled ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        sender.image = image
    }
}
