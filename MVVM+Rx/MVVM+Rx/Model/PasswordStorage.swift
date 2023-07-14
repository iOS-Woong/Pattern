//
//  PasswordStorage.swift
//  MVVM+Rx
//
//  Created by 서현웅 on 2023/07/14.
//

import Foundation

protocol Storage {
    var password: String? { get set }
    var confirm: String? { get set }
    var isEqualOriginPassword: Bool { get }
}

struct PasswordStorage: Storage {
    var password: String?
    var confirm: String?
    var isEqualOriginPassword: Bool {
        password == confirm
    }
}
