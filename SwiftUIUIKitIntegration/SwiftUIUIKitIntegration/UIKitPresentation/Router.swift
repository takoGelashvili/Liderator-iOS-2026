//
//  Router.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

import UIKit
import SwiftUI

protocol Router {
    func navigateToSwiftUI()
}

struct RouterImpl: Router {
    private weak var viewController: ViewController?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func navigateToSwiftUI() {
        let hosting = UIHostingController(rootView: SwiftUIPage())
        viewController?.navigationController?.pushViewController(hosting, animated: true)
    }
}
