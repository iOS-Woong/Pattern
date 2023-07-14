//
//  ViewModel.swift
//  MVVM+Rx
//
//  Created by 서현웅 on 2023/07/14.
//

import Foundation
import RxSwift

class ViewModel {
    private let validator: Validator
    
    private (set) var id: PublishSubject<ValidationState> = PublishSubject()
    private (set) var pw: PublishSubject<ValidationState> = PublishSubject()
    private (set) var confirm: PublishSubject<ValidationState> = PublishSubject()
    private (set) var validateAll: PublishSubject<Bool> = PublishSubject()
    
    init(validator: Validator = SignInValidator()) {
        self.validator = validator
    }
}

extension ViewModel {
    func textFieldDidChanged(_ text: String?, type: ValidationType) {
        
        switch type {
        case .id:
            id.onNext(validator.validate(text, type: .id))
        case .pw:
            pw.onNext(validator.validate(text, type: .pw))
        case .confirm:
            confirm.onNext(validator.validate(text, type: .confirm))
        }
        
        validateAll.onNext(validator.validateAll())
    }
}
