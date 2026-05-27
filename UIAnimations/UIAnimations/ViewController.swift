//
//  ViewController.swift
//  UIAnimations
//
//  Created by Tamar Gelashvili on 27/05/2026.
//

import UIKit

class ViewController: UIViewController {
    
    var isExpanded: Bool = false
    
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    private let container: UIView = {
        let c = UIView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let square: UIView = {
        let s = UIView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .cyan
        return s
    }()
    
    private let greenSquare: UIView = {
        let s = UIView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .green
        return s
    }()
    
    private let button: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Animate", for: .normal)
        b.backgroundColor = .systemPink
        return b
    }()
    
    private let vStack: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alignment = .center
        v.distribution = .equalSpacing
        v.axis = .vertical
        return v
    }()
    
    @objc
    func changeSizConstraints() {
        isExpanded.toggle()
        
        self.widthConstraint.constant = self.isExpanded ? 300 : 100
        self.heightConstraint.constant = self.isExpanded ? 100 : 300
        
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func addTransform() {
        UIView.animate(withDuration: 2) {
            //            self.button.transform = .init(rotationAngle: .pi)
            self.square.transform = .init(scaleX: 3, y: 3).concatenating(.init(translationX: 50, y: 50))
        } completion: { completed in
            UIView.animate(withDuration: 2) {
                self.square.transform = .identity
            }
        }
    }
    
    @objc
    func spring() {
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.9) {
            self.square.transform = .init(translationX: 50, y: 0)
        }
    }
    
    @objc
    func changeColor() {
        UIView.animate(withDuration: 2, delay: 1, options: []) {
            self.square.backgroundColor = .red
        }
    }
    
    @objc
    func disappear() {
        UIView.animate(withDuration: 2, delay: .zero, options: [.autoreverse]) {
            self.square.alpha = 0
        }
    }
    
    @objc
    func round() {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 0
        animation.toValue = 50
        animation.duration = 2
        animation.autoreverses = true
        square.layer.add(animation, forKey: "round")
    }
    
    @objc
    func border() {
        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = UIColor.black.cgColor
        colorAnimation.toValue = UIColor.white.cgColor
        
        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = 0
        borderWidthAnimation.toValue = 10
        
        let group = CAAnimationGroup()
        group.animations = [colorAnimation, borderWidthAnimation]
        group.duration = 2
        group.autoreverses = true
        group.repeatCount = 2

        square.layer.add(group, forKey: "border")
    }
    
    @objc
    func keypath() {
        UIView.animateKeyframes(withDuration: 3, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) {
                self.square.transform = .init(translationX: 100, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                self.square.transform = .init(translationX: 100, y: 100)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                self.square.transform = .init(translationX: 0, y: 100)
            }
        }
    }
    
    var isGreenShowing: Bool = false
    var animator: UIViewPropertyAnimator?
        
    @objc
    func property() {
        animator = UIViewPropertyAnimator(duration: 3, dampingRatio: 0.7, animations: {
            self.widthConstraint.constant = self.isExpanded ? 300 : 100
            self.heightConstraint.constant = self.isExpanded ? 100 : 300
            
            self.view.layoutIfNeeded()
        })
        
        animator?.startAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animator?.pauseAnimation()
        }
    }
    
    @objc
    func flip() {
        isGreenShowing.toggle()

        let from = isGreenShowing ? square : greenSquare
        let to = isGreenShowing ? greenSquare : square
        
        UIView.transition(
            from: from,
            to: to,
            duration: 2,
            options: [.transitionCurlUp, .showHideTransitionViews]
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(property), for: .touchUpInside)

        view.backgroundColor = .white
        
        view.addSubview(vStack)
        vStack.addArrangedSubview(container)
        vStack.addArrangedSubview(button)
        
        container.addSubview(greenSquare)
        container.addSubview(square)
                
        widthConstraint = container.widthAnchor.constraint(equalToConstant: 100)
        heightConstraint = container.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint,
            
            square.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            square.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            square.topAnchor.constraint(equalTo: container.topAnchor),
            square.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            greenSquare.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            greenSquare.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            greenSquare.topAnchor.constraint(equalTo: container.topAnchor),
            greenSquare.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),

            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
}

