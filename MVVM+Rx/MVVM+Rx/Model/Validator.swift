//
//  Validator.swift
//  MVVM+Rx
//
//  Created by 서현웅 on 2023/07/14.
//

import Foundation

enum ValidationType {
    case id, pw, confirm
}

enum ValidationState {
    case empty, valid, invalid
}

protocol Validator {
    var passwordStorage: Storage { get }
    func validate(_ text: String?, type: ValidationType) -> ValidationState
    func validateAll() -> Bool
}

class SignInValidator: Validator {
    var passwordStorage: Storage
    
    private var idValidation: Bool = false
    private var pwValidation: Bool = false
    private var confirmValidation: Bool = false
    
    init(passwordStorage: Storage = PasswordStorage()) {
        self.passwordStorage = passwordStorage
    }
    
    func validate(_ text: String?, type: ValidationType) -> ValidationState {
        guard let text else { return .empty }
        
        switch type {
        case .id:
            return validateId(text)
        case .pw:
            return validatePw(text)
        case .confirm:
            return validateConfirm(text)
        }
        
    }
    
    func validateAll() -> Bool {
         return idValidation && pwValidation && confirmValidation
    }
}

extension SignInValidator {
    private func validateId(_ text: String) -> ValidationState {
        idValidation = checkLimitLength(text, count: 5)
        
        return idValidation ? .valid : .invalid
    }
    
    private func validatePw(_ text: String) -> ValidationState {
        passwordStorage.password = text
        pwValidation = checkLimitLength(text, count: 7)
        
        return pwValidation ? .valid : .invalid
    }
    
    private func validateConfirm(_ text: String) -> ValidationState {
        passwordStorage.confirm = text
        confirmValidation = passwordStorage.isEqualOriginPassword
        
        return confirmValidation ? .valid : .invalid
    }
    
    private func checkLimitLength(_ text: String, count: Int) -> Bool {
        return text.count > count
    }
    
}
