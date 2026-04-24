//
//  ViewController.swift
//  shuqnishani
//
//  Created by Tamar Gelashvili on 24/04/2026.
//

import UIKit

final class ViewController: UIViewController {
    lazy var trafficLight: TrafficLightView = {
        let view = TrafficLightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        print("Init view controller")
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        print("Init view controller")
    }
    
    override func loadView() {
        super.loadView()
        print("Load View")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addContraints()
        print("View did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View did appear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("View did layout")
    }
}

extension ViewController {
    private func addSubviews() {
        view.addSubview(trafficLight)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            trafficLight.widthAnchor.constraint(equalToConstant: 200),
            trafficLight.heightAnchor.constraint(equalToConstant: 400),
            trafficLight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trafficLight.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
