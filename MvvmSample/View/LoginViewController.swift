//
//  LoginViewController.swift
//  MvvmSample
//
//  Created by M1086289 on 07/06/22.
//

import UIKit

enum LoginTextFields: Int {
    case username = 100
    case password = 200
}

class LoginViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loadingView: UIView!
    private var viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        configureTextFields()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    @IBAction private func actionSigin(_ sender:Any) {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        loadingView.isHidden = false
        viewModel.signIn(username: username, password: password) { result in
            DispatchQueue.main.async {
                self.loadingView.isHidden = true
                switch result {
                case .success(let isloginsuceess):
                    let message = isloginsuceess ? "User Logged in Successfully" : "Could not Login User"
                    let title = isloginsuceess ? "Success" : "Failure"
                    self.showAlert(title: title, messaage: message)
                case .failure(let error):
                    let errormessage = "error encountered \(error)"
                    self.showAlert(title: "Failed", messaage: errormessage)
                }
            }
            
        }
    }
    
    @IBAction private func actionForgotPassword(_ sender: Any) {
        
    }
    
    @IBAction private func actionCreateAccounr(_ sender: Any) {
        
    }
    
    private func configureTextFields() {
        usernameField.layer.borderColor = UIColor.red.cgColor
        passwordField.layer.borderColor = UIColor.red.cgColor
        usernameField.layer.borderWidth = 1.0
        passwordField.layer.borderWidth = 1.0
    }
    
    private func showAlert(title: String,messaage: String) {
        let alert = UIAlertController(title: "User Status", message: messaage, preferredStyle: .alert)
        let action1 = UIAlertAction(title: title,style: .default)
        alert.addAction(action1)
        self.present(alert, animated: true)
    }
    
    @IBAction private func didTapView(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldTag = LoginTextFields(rawValue: textField.tag) else { return }
        switch textFieldTag {
        case .username:
            passwordField.becomeFirstResponder()
        case .password:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let inputText = text.replacingCharacters(in: textRange,
                                                     with: string)
            var isValid = false
            
            switch textField.tag {
            case LoginTextFields.username.rawValue:
                isValid = Utility.isValidEmail(inputText)
            case LoginTextFields.password.rawValue:
                isValid = Utility.isValidPassword(inputText)
            default:
                break
            }
            
            if isValid {
                textField.layer.borderColor = UIColor.darkGray.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
            }
            
        }
        
        return true
    }
    
}

