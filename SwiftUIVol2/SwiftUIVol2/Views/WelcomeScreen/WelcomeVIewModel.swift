//
//  WelcomeVIewModel.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 12/06/2026.
//

struct WelcomeViewModelState {
    var username: String
    var password: String
    
    var isTextFieldInErrorState: Bool {
        password.count > 20
    }
}

protocol WelcomeViewModel {
    func didTapLogin() async
    func didTapSignUp() async
    
    var state: WelcomeViewModelState { get set }
}


struct WelcomeViewModelImpl: WelcomeViewModel {
    var state: WelcomeViewModelState = .init(username: "", password: "")

    func didTapLogin() async {
        print("TAP LOGIN")
    }
    
    func didTapSignUp() async  {
        print("TAP SIGN UP")
    }
}
