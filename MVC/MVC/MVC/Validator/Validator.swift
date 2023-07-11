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

final class SignInValidator: Validator {
    
    func validate(text: String?, _ type: ValidationType) -> Bool {
        guard let text else { return false }
        
        switch type {
        case .id:
            print("idValid")
        case .password:
            print("passwordValid")
        case .confirm:
            print("confirm Valid")
        }
        
        return true
    }
    
    
}
