//
//  ViewController.swift
//  MVC
//
//  Created by 서현웅 on 2023/07/12.
//

import UIKit

class ViewController: UIViewController {
    private let validator = SignInValidator()
    
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultButtonAppearance()
        setupSubviewsAppearance()
    }
    
    private func setupDefaultButtonAppearance() {
        signInButton.setBackgroundColor(state: .disabled)
    }
    
    private func setupSubviewsAppearance() {
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

    @IBAction func editChangedIDTextField(_ sender: UITextField) {
        validator.validate(text: sender.text, .id)
    }
    
    @IBAction func editChangedPWTextField(_ sender: UITextField) {
        validator.validate(text: sender.text, .password)
    }
    
    @IBAction func editChagnedConfirmPWTextField(_ sender: UITextField) {
        validator.validate(text: sender.text, .confirm)
    }
    
    
    
    @IBAction func signInAction(_ sender: UIButton) {
        
    }
}
