//
//  LoginViewController.swift
//  Yamb
//
//  Created by Ana Peshevska on 19.4.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        return label
    }()
    
    lazy var emailField: CustomLoginTextField = {
        var emailField = CustomLoginTextField()
        emailField.placeholder = "Email address"
        return emailField
    }()
    
    lazy var passwordField: CustomLoginTextField = {
        var passField = CustomLoginTextField()
        passField.placeholder = "Password"
        passField.isSecureTextEntry = true
        return passField
    }()
    
    lazy var forgotPass: CustomLoginButton = {
        var button = CustomLoginButton()
        button.backgroundColor = .white
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Forgot Password?", for: .normal)
        return button
    }()
    
    lazy var continueButton: CustomLoginButton = {
        var button = CustomLoginButton()
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
        return button
    }()
    
    lazy var continueWithApple: CustomLoginButton = {
        var button = CustomLoginButton()
        button.backgroundColor = .black
        button.setTitle("Continue with Apple", for: .normal)
        return button
    }()
    
    lazy var continueWithGoogle: CustomLoginButton = {
        var button = CustomLoginButton()
        button.backgroundColor = .white
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Continue with Google", for: .normal)
        return button
    }()
    
    lazy var dontHaveAnAcc: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return label
    }()
    
    lazy var registerButton: CustomLoginButton = {
        var button = CustomLoginButton()
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var errorMessage: CustomErrorLabel = {
        var label = CustomErrorLabel()
        label.text = "All fields are required"
        return label
    }()
    
    lazy var loginStack = UIStackView(arrangedSubviews: [UIView(), titleLabel, errorMessage, emailField, passwordField, forgotPass, continueButton, continueWithApple, continueWithGoogle, dontHaveAnAcc, registerButton, UIView()], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginStack)
        loginStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        view.backgroundColor = .white
    }
    
    @objc func onContinue(_ sender: UIButton) {
        if emailField.text?.count == 0 || passwordField.text?.count == 0 {
            errorMessage.isHidden = false
        }
        else {
            show(YambViewController(), sender: self)
        }
    }
    
    @objc func onRegister(_ sender: UIButton) {
        show(RegisterViewController(), sender: self)
    }
    
}
