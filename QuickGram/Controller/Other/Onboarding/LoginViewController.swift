//
//  LoginViewController.swift
//  QuickGram
//
//  Created by Chirag Goel on 07/09/21.
//

import UIKit
import SafariServices
import FirebaseAuth

class LoginViewController: UIViewController {
    
    struct Constants{
        static let cornerRadius : CGFloat = 8.0
    }
    
    // anonymous clousure
    
    private let headerView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backroundImage = UIImageView(image: UIImage(named:  "gradient"))
        
        view.addSubview(backroundImage)
        return view
    }()
    
    
    
    private let usernameEmailField : UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
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
    
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In ",for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white,for: .normal)
        return button
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label,for: .normal)
        button.setTitle("New User ? Create An Account",for: .normal)
        return button
    }()
    
  
    private let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service ",for: .normal)
        button.setTitleColor(.secondaryLabel,for: .normal)
        return button
    }()
    
    
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy ",for: .normal)
        button.setTitleColor(.secondaryLabel,for: .normal)
        return button

    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubView()
        
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        //headerView
        
        headerView.frame = CGRect(x: 0 , y: 0, width: view.width, height: view.height/3.0)
        configureHeaderView()
        
        //username
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 10, width: view.width-50, height: 52.0)
        
        //password
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom+10, width: view.width-50, height: 52.0)
        
        //loginButton
        
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52.0)
        //create Account
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50 , height: 52.0 )
        
        //termsButton
        termsButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        
        //privacyPolicy
        privacyButton.frame = CGRect(x: 10, y:view.height-view.safeAreaInsets.bottom-50, width: view.width-20, height:50)
        
    }
    
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard  let usernameEmail = usernameEmailField.text ,!usernameEmail.isEmpty,
               let password = passwordField.text ,!password.isEmpty else {
                    return
        }
        var username : String?
        var email : String?
        if usernameEmail.contains("@"),usernameEmail.contains(".") {
            email = usernameEmail
        }
        else{
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username , email: email, password: password) { (done) in
            DispatchQueue.main.async {
                if done {
                    self.dismiss(animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
            
    }
    
    @objc private func didTapTermsButton(){
        guard let url =  URL(string: "https://policies.google.com/terms") else{
            return
        }
        let vc = SFSafariViewController(url : url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton(){
        guard let url =  URL(string: "https://policies.google.com/privacy") else{
            return
        }
        let vc = SFSafariViewController(url : url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "Create Acc ount"
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    private func addSubView(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        
        view.addSubview(createAccountButton)
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        
        guard let
                backgroundView = headerView.subviews.first  else {
            return
        }
        backgroundView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0 , y: view.safeAreaInsets.top, width: headerView.width/2.0 , height: headerView.height - view.safeAreaInsets.top)
    }
}
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
