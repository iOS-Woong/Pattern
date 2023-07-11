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
    func validate(text: String?, _ validateObject: ValidationType) -> Bool
}

// external
final class SignInValidator: Validator {
    func validate(text: String?, _ type: ValidationType) -> Bool {
        guard let text else { return false }
        
        switch type {
        case .id:
            return checkIdValidation(text)
        case .password:
            return checkPWValidation(text)
        case .confirm:
            print("confirm Valid")
        }
        
        return true
    }
}

// internal
extension SignInValidator {
    private func checkIdValidation(_ text: String) -> Bool {
        if text.count > 5 {
            return true
        }
        return false
    }
    
    private func checkPWValidation(_ text: String) -> Bool {
        if text.count > 7 {
            return true
        }
        return false
    }
    
    private func checkConfirmPWValidation(_ text: String) -> Bool {
        
        
        
        return false
    }
    
}
