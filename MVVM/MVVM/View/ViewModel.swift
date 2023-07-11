//
//  ViewModel.swift
//  MVVM
//
//  Created by 서현웅 on 2023/07/12.
//

import Foundation

class ViewModel {
    private let validator: Validator
    
    private var id: ValidationState = .empty {
        didSet {
            idHandler?(id)
        }
    }
    private var password: ValidationState = .empty {
        didSet {
            passwordHandler?(password)
        }
    }
    private var confirm: ValidationState = .empty {
        didSet {
            confirmPasswordHandler?(confirm)
        }
    }
    private var validateAll: Bool = false {
        didSet {
            validateAllHandler?(validateAll)
        }
    }
    
    private var idHandler: ((ValidationState) -> Void)?
    private var passwordHandler: ((ValidationState) -> Void)?
    private var confirmPasswordHandler: ((ValidationState) -> Void)?
    private var validateAllHandler: ((Bool) -> Void)?
    
    init(validator: Validator = SignInValidator()) {
        self.validator = validator
    }
    
}

// bind
extension ViewModel {
    func bindID(handler: @escaping ((ValidationState) -> Void)) {
        self.idHandler = handler
    }
    
    func bindPassword(handler: @escaping ((ValidationState) -> Void)) {
        self.passwordHandler = handler
    }
    
    func bindConfirm(handler: @escaping ((ValidationState) -> Void)) {
        self.confirmPasswordHandler = handler
    }
    
    func bindValidateAll(handler: @escaping ((Bool) -> Void)) {
        self.validateAllHandler = handler
    }
}

// value changed
extension ViewModel {
    func textFieldDidChanged(_ text: String?, type: ValidationType) {
        switch type {
        case .id:
            id = validator.validate(text, type: .id)
        case .password:
            password = validator.validate(text, type: .password)
        case .confirmPassword:
            confirm = validator.validate(text, type: .confirmPassword)
        }
        
        validateAll = validator.validateAll()
    }
}
