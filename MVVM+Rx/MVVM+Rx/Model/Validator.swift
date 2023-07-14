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

protocol Validator {
    var passwordStorage: Storage { get }
    func validate(_ text: String?, type: ValidationType)
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
    
    func validate(_ text: String?, type: ValidationType) {
        guard let text else { return }
        
        
        switch type {
        case .id:
            validateId(text)
        case .pw:
            validatePw(text)
        case .confirm:
            validateConfirm(text)
        }
        
    }
    
    func validateAll() -> Bool {
         return idValidation && pwValidation && confirmValidation
    }
}

extension SignInValidator {
    private func validateId(_ text: String) -> Bool {
        idValidation = checkLimitLength(text, count: 5)
        
        return idValidation
    }
    
    private func validatePw(_ text: String) -> Bool {
        passwordStorage.password = text
        pwValidation = checkLimitLength(text, count: 7)
        
        return pwValidation
    }
    
    private func validateConfirm(_ text: String) -> Bool {
        passwordStorage.confirm = text
        confirmValidation = passwordStorage.isEqualOriginPassword
        
        return confirmValidation
    }
    
    private func checkLimitLength(_ text: String, count: Int) -> Bool {
        return text.count > count
    }
    
}
