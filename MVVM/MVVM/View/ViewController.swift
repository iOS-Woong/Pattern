//
//  ViewController.swift
//  MVVM
//
//  Created by 서현웅 on 2023/07/12.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setUpSubviewsAppearance()
    }
    
    private func setupBinding() {
        viewModel
            .bindID(handler: { [weak self] in
                print($0)
                self?.idTextField.layer.borderColor = self?.appropriatedColor(with: $0)
        })
        
        viewModel
            .bindPassword(handler: { [weak self] in
                self?.pwTextField.layer.borderColor = self?.appropriatedColor(with: $0)
        })
        
        viewModel
            .bindConfirm(handler: { [weak self] in
                self?.confirmPwTextField.layer.borderColor = self?.appropriatedColor(with: $0)
            })
        
        viewModel
            .bindValidateAll(handler: { [weak self] in
                self?.signInButton.isEnabled = $0
            })
    }
    
    private func appropriatedColor(with state: ValidationState) -> CGColor {
        switch state {
        case .empty:
            return Style.TextField.BorderColor.empty
            
        case .valid:
            return Style.TextField.BorderColor.valid
            
        case .invalid:
            return Style.TextField.BorderColor.invalid
        }
    }
    
    private func setUpSubviewsAppearance() {
        setUpSignUpButtonAppearance()
        setUpTextFieldsAppearance()
    }
    
    private func setUpSignUpButtonAppearance() {
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = Style.SignUpButton.cornerRadius
        signInButton.setBackgroundColor(.systemGray, for: .disabled)
        signInButton.isEnabled = false
    }
    
    private func setUpTextFieldsAppearance() {
        setUpTextFieldAppearance(idTextField)
        setUpTextFieldAppearance(pwTextField)
        setUpTextFieldAppearance(confirmPwTextField)
    }
    
    private func setUpTextFieldAppearance(_ textField: UITextField?) {
        textField?.layer.borderColor = Style.TextField.BorderColor.empty
        textField?.layer.borderWidth = Style.TextField.borderWidth
        textField?.layer.cornerRadius = Style.TextField.cornerRadius
        textField?.textContentType = .oneTimeCode
    }
    
    @IBAction func idTextFieldChanged(_ sender: UITextField) {
        viewModel.textFieldDidChanged(sender.text, type: .id)
    }
    
    @IBAction func pwTextFieldChanged(_ sender: UITextField) {
        viewModel.textFieldDidChanged(sender.text, type: .password)
    }
    
    @IBAction func confirmTextFieldChanged(_ sender: UITextField) {
        viewModel.textFieldDidChanged(sender.text, type: .confirmPassword)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        
    }
}

// MARK: - Style
extension ViewController {
    private enum Style {
        enum SignUpButton {
            static let cornerRadius: CGFloat = 5
        }
        
        enum TextField {
            enum BorderColor {
                static let empty: CGColor = UIColor.systemGray.cgColor
                static let valid: CGColor = UIColor.green.cgColor
                static let invalid: CGColor = UIColor.red.cgColor
            }
            
            static let cornerRadius: CGFloat = 5
            static let borderWidth: CGFloat = 1
        }
    }
}
