//
//  ViewController.swift
//  MVC
//
//  Created by 서현웅 on 2023/07/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultButtonAppearance()
        setupSubviews()
    }
    
    private func setupDefaultButtonAppearance() {
        signInButton.setBackgroundColor(state: .disabled)
    }
    
    private func setupSubviews() {
        setupTextFieldAppearance([idTextField, pwTextField, confirmPwTextField])
        setupTextFieldSecureContentType([pwTextField, confirmPwTextField])
    }
    
    private func setupTextFieldAppearance(_ textFields: [UITextField]) {
        let defaultBorderWidth = 2.0
        
        textFields.forEach {
            $0.layer.borderColor = UIColor.empty.cgColor
            $0.layer.borderWidth = defaultBorderWidth
        }
    }
    
    private func setupTextFieldSecureContentType(_ textFields: [UITextField]) {
        textFields.forEach {
            $0.textContentType = .oneTimeCode
            $0.isSecureTextEntry = true
        }
    }

    @IBAction func signInAction(_ sender: UIButton) {
        
    }
}
