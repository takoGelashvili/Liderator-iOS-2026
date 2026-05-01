//
//  Presenter.swift
//  CustomReusable
//
//  Created by Tamar Gelashvili on 01/05/2026.
//

import Foundation

protocol Presenter: AnyObject {
    func viewDidLoad()
    func isValid(text: String) -> (Bool, errorText: String?) // ან ესე ან struct. struct ჯობია ისე
}

final class PresenterImpl: Presenter {
        
    weak var view: ViewProtocol?
    
    init(view: ViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.displayTextField()
    }
    
    func isValid(text: String) -> (Bool, errorText: String?) {
        let isNumber = text.range(of: #"^[0-9]*$"#, options: .regularExpression) != nil
        let length = text.count
        
        if !isNumber {
            return (false, "Only numbers allowed")
        }
        
        if length > 9 {
            return (false, "Only 9 numbers allowed")
        }
        
        return (true, nil)
    }
}
