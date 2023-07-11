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
        setupDefaultButtonAppearance(state: .disabled)
        setupSubviewsAppearance()
    }
    
    private func setupDefaultButtonAppearance(state: UIControl.State) {
        signInButton.setBackgroundColor(state: state)
    }
    
    private func setupSubviewsAppearance() {
        setupTextFieldAppearance([idTextField, pwTextField, confirmPwTextField], state: .empty)
        setupTextFieldSecureContentType([pwTextField, confirmPwTextField])
    }
    
    private func setupTextFieldAppearance(_ textFields: [UITextField], state: UIColor) {
        let defaultBorderWidth = 2.0
        
        textFields.forEach {
            $0.layer.borderColor = state.cgColor
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
        validator.validate(text: sender.text, .id) ? setupTextFieldAppearance([sender], state: .valid) : setupTextFieldAppearance([sender], state: .invalid)
        validator.validateButton() ? setupDefaultButtonAppearance(state: .normal) : setupDefaultButtonAppearance(state: .disabled)
    }
    
    @IBAction func editChangedPWTextField(_ sender: UITextField) {
        validator.validate(text: sender.text, .password) ? setupTextFieldAppearance([sender], state: .valid) : setupTextFieldAppearance([sender], state: .invalid)
        validator.validateButton() ? setupDefaultButtonAppearance(state: .normal) : setupDefaultButtonAppearance(state: .disabled)
    }
    
    @IBAction func editChagnedConfirmPWTextField(_ sender: UITextField) {
        if validator.validate(text: sender.text, .confirm) {
            setupTextFieldAppearance([sender], state: .valid)
            validator.validateButton() ? setupDefaultButtonAppearance(state: .normal) : setupDefaultButtonAppearance(state: .disabled)
        } else {
            setupTextFieldAppearance([sender], state: .invalid)
            validator.validateButton() ? setupDefaultButtonAppearance(state: .normal) : setupDefaultButtonAppearance(state: .disabled)
        }
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        showTestAlert()
    }
}

// For Test
extension ViewController {
    func showTestAlert() {
        let alertController = UIAlertController(title: "됨요로그인", message: "네", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "네", style: .cancel)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}
