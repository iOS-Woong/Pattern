//
//  ViewController.swift
//  MVVM+Rx
//
//  Created by 서현웅 on 2023/07/14.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUpSubviewsAppearance()
    }

    private func bind() {
        viewModel.id
            .subscribe { [weak self] in
                self?.idTextField.layer.borderColor = self?.appropriateColor($0)
            }
            .disposed(by: disposeBag)
        
        viewModel.pw
            .subscribe(onNext: { [weak self] in
                self?.pwTextField.layer.borderColor = self?.appropriateColor($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.confirm
            .subscribe(onNext: { [weak self] in
                self?.confirmPwTextField.layer.borderColor = self?.appropriateColor($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.validateAll
            .subscribe(onNext: { [weak self] in
                self?.signInButton.isEnabled = $0
            })
            .disposed(by: disposeBag)
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
    
    private func appropriateColor(_ state: ValidationState) -> CGColor {
        switch state {
        case .empty:
            return Style.TextField.BorderColor.empty
            
        case .valid:
            return Style.TextField.BorderColor.valid
            
        case .invalid:
            return Style.TextField.BorderColor.invalid
        }
    }
    
    
    @IBAction func idTextFieldDidChanged(_ sender: UITextField) {
        viewModel.textFieldDidChanged(sender.text, type: .id)
    }
    
    @IBAction func pwTextFieldDidChanged(_ sender: UITextField) {
        viewModel.textFieldDidChanged(sender.text, type: .pw)
    }
    
    @IBAction func confirmTextFieldDidChanged(_ sender: UITextField) {
        viewModel.textFieldDidChanged(sender.text, type: .confirm)
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
