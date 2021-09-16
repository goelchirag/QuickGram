//
//  RegistrationViewController.swift
//  QuickGram
//
//  Created by Chirag Goel on 07/09/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    struct  Constants {
        public static var cornerRadius : CGFloat = 8.0
    }
    private let usernameField : UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.leftView = UIView(frame : CGRect(x :0 , y: 0, width :10,height : 0) )
        field.autocapitalizationType = .none
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    private let emailField : UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.leftView = UIView(frame : CGRect(x :0 , y: 0, width :10,height : 0) )
        field.autocapitalizationType = .none
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    private let passwordField : UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        field.leftView = UIView(frame : CGRect(x :0 , y: 0, width :10,height : 0) )
        field.autocapitalizationType = .none
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.isSecureTextEntry = true
        return field
    }()
    
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign UP ",for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white,for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerButton.addTarget(self, action: #selector(didtapRegister), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
    }
    
    @objc private func didtapRegister(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        
        guard let email = emailField.text ,!email.isEmpty,
              let username = usernameField.text ,!username.isEmpty,
              let password = passwordField.text,!password.isEmpty,password.count >= 8 else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if(success){
                    print("successfull")
                }else{
                    
                }
            }
            
        }
    }
}
extension RegistrationViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == usernameField ){
            emailField.becomeFirstResponder()
        }else if ( textField == emailField ){
            passwordField.becomeFirstResponder()
        }
        else{
            didtapRegister()
        }
        return true
    }
}
