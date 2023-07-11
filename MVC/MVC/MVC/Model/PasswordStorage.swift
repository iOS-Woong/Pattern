//
//  PasswordStorage.swift
//  MVC
//
//  Created by 서현웅 on 2023/07/12.
//

import Foundation

protocol Storage {
    var password: String? { get set }
    var confirmPassword: String? { get set }
    var isEqualOriginPassword: Bool { get }
}

struct PasswordStorage: Storage {
    var password: String?
    var confirmPassword: String?
    var isEqualOriginPassword: Bool {
        return password == confirmPassword
    }
}
