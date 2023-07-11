//
//  Validator.swift
//  MVC
//
//  Created by 서현웅 on 2023/07/12.
//

import Foundation

enum ValidationType {
    case id, password, confirm
}

protocol Validator {
    var passwordStorage: Storage { get }
    func validate(text: String?, _ validateObject: ValidationType) -> Bool
}

final class SignInValidator: Validator {
    private let idValidLength: Int = 5
    private let pwValidLength: Int = 7
    private (set) var passwordStorage: Storage
    
    func validate(text: String?, _ type: ValidationType) -> Bool {
        guard let text else { return false }
        
        switch type {
        case .id:
            return checkIdValidation(text)
        case .password:
            return checkPWValidation(text)
        case .confirm:
            return checkConfirmPWValidation(text)
        }
    }
    
    init(passwordStorage: Storage = PasswordStorage()) {
        self.passwordStorage = passwordStorage
    }
}

// internal
extension SignInValidator {
    private func checkIdValidation(_ text: String) -> Bool {
        return validateLength(text, count: idValidLength)
    }
    
    private func checkPWValidation(_ text: String) -> Bool {
        passwordStorage.password = text
        return validateLength(text, count: pwValidLength)
    }
    
    private func checkConfirmPWValidation(_ text: String) -> Bool {
        passwordStorage.confirmPassword = text
        return passwordStorage.isEqualOriginPassword
    }
    
    private func validateLength(_ text: String, count: Int) -> Bool {
        return text.count > count
    }
}
