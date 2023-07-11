//
//  ViewModel.swift
//  MVVM
//
//  Created by 서현웅 on 2023/07/12.
//

import Foundation

class ViewModel {
    private let validator: Validator
    
    
    
    init(validator: Validator = SignInValidator()) {
        self.validator = validator
    }
}
