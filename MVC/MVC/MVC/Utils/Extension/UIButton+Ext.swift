//
//  UIButton+Ext.swift
//  MVC
//
//  Created by 서현웅 on 2023/07/12.
//

import UIKit

extension UIButton {
    func setBackgroundColor(state: UIControl.State) {
        switch state {
        case .disabled:
            self.tintColor = .systemGray
            self.isUserInteractionEnabled = false
        default :
            self.tintColor = .systemGreen
            self.isUserInteractionEnabled = true
        }
        
    }
    
}
