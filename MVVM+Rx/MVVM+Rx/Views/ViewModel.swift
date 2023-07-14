//
//  ViewModel.swift
//  MVVM+Rx
//
//  Created by 서현웅 on 2023/07/14.
//

import Foundation

class ViewModel {
    private let validator: Validator
    
    init(validator: Validator = SignInValidator()) {
        self.validator = validator
    }
    
}

extension ViewModel {
    func textFieldDidChanged(_ text: String?, type: ValidationType) {
        validator.validate(text, type: type)
    }
}
