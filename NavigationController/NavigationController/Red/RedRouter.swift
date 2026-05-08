//
//  RedRouter.swift
//  NavigationController
//
//  Created by Tamar Gelashvili on 08/05/2026.
//

import UIKit

final class RedRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    func navigateToBlue() {
        let secondVC = BlueViewController()
        viewController?.navigationController?.pushViewController(secondVC, animated: true)
    }
}
