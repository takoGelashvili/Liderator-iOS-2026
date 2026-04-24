//
//  TrafficLightView.swift
//  shuqnishani
//
//  Created by Tamar Gelashvili on 24/04/2026.
//

import UIKit

enum LightType {
    case red
    case yellow
    case green
    
    var color: UIColor {
        switch self {
        case .red: return .systemRed
        case .yellow: return .systemYellow
        case .green: return .systemGreen
        }
    }
}

final class TrafficLightView: UIView {
    lazy var greyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var lights: [UIView] = {
        let red = makeCircle(.red)
        let yellow = makeCircle(.yellow)
        let green = makeCircle(.green)
        
        let view: [UIView] = [red, yellow, green]
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        print("willMove")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        print("will move", newWindow ?? "nil")
    }
    
    override func draw(_ rect: CGRect) {
        print("Draw")
    }
    
    var size: SIze
    
    override func layoutSubviews() {
        print("Layout subview for view")
    }
}

extension TrafficLightView {
    private func commonInit() {
        addSubViews()
        addContraints()
    }
    
    private func addSubViews() {
        addSubview(greyView)
        greyView.addSubview(stackView)
        stackView.addArrangedSubview(lights[0])
        stackView.addArrangedSubview(lights[1])
        stackView.addArrangedSubview(lights[2])
    }
    
    private func addContraints() {
        addGreyViewContraints()
        addStackViewContraints()
        addLightContraints()
    }
    
    private func addGreyViewContraints() {
        NSLayoutConstraint.activate([
            greyView.topAnchor.constraint(equalTo: topAnchor),
            greyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greyView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addStackViewContraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: greyView.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: greyView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: greyView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: greyView.bottomAnchor, constant: -40)
        ])
    }
    
    private func addLightContraints() {
        for vLight in lights {
            NSLayoutConstraint.activate([
                vLight.widthAnchor.constraint(equalToConstant: consts.circleSize),
                vLight.heightAnchor.constraint(equalToConstant: consts.circleSize)
            ])
        }
    }
    
    typealias consts = TrafficLightConts
    
    private func makeCircle(_ type: LightType) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = type.color
        v.layer.cornerRadius = consts.circleSize / 2
        return v
    }
}

struct TrafficLightConts {
    static let circleSize: CGFloat = 80
}
