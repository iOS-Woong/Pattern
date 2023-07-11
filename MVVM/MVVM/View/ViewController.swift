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
        
    }

    @IBAction func signInButton(_ sender: UIButton) {
        
    }
    

}

