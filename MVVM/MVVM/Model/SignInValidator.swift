//
//  SignInValidator.swift
//  MVVM
//
//  Created by 서현웅 on 2023/07/12.
//

import Foundation

enum ValidationState {
    case empty, valid, invalid
}

enum ValidationType {
    case id, password, confirmPassword
}

protocol Validator {
    var passwordStorage: Storage { get }
    func validate(_ text: String?, type: ValidationType) -> ValidationState
    func validateAll() -> Bool
}

final class SignInValidator: Validator {
    var passwordStorage: Storage
    
    private var isIDValidated: Bool = false
    private var isPasswordValidated: Bool = false
    private var isConfirmPasswordValidated: Bool = false
    
    init(passwordStorage: Storage = PasswordStorage()) {
        self.passwordStorage = passwordStorage
    }
    
    func validateAll() -> Bool {
        return isIDValidated && isPasswordValidated && isConfirmPasswordValidated
    }
    
    func validate(_ text: String?, type: ValidationType) -> ValidationState {
        guard let text = text,
              text.isEmpty == false else {
            return .empty
        }
        
        switch type {
        case .id:
            return validateID(text)
        
        case .password:
            return validatePassword(text)
            
        case .confirmPassword:
            return validateConfirmPassword(text)
        }
    }
}

// internal
extension SignInValidator {
    private func validateID(_ id: String) -> ValidationState {
        isIDValidated = validateLength(id, count: 5)
        
        return isIDValidated ? .valid : .invalid
    }
    
    private func validatePassword(_ pw: String) -> ValidationState {
        passwordStorage.password = pw
        isPasswordValidated = validateLength(pw, count: 7)
        
        return isPasswordValidated ? .valid : .invalid
    }
    
    private func validateConfirmPassword(_ confirm: String) -> ValidationState {
        passwordStorage.confirmPassword = confirm
        isConfirmPasswordValidated = passwordStorage.isEqualOriginPassword
        
        return isConfirmPasswordValidated ? .valid : .invalid
    }
    
    private func validateLength(_ text: String, count: Int) -> Bool {
        return text.count > count
    }
}
