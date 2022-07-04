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
    
    lazy var emailField: UITextField = {
        var emailField = UITextField()
        emailField.placeholder = "Email Address"
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return emailField
    }()
    
    lazy var passwordField: UITextField = {
        var passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.layer.borderColor = UIColor.black.cgColor
        passField.isSecureTextEntry = true
        passField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return passField
    }()
    
    lazy var forgotPass: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Forgot Password?"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return label
    }()
    
    lazy var continueButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return button
    }()
    
    lazy var continueWithApple: UIButton = {
        var button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue with Apple", for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return button
    }()
    
    lazy var continueWithGoogle: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        //button.layer.borderColor =  UIColor(ciColor: .black).cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Continue with Google", for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
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
    
    lazy var registerButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return button
    }()
    
    //var shouldShowError = false
    
    lazy var errorMessage: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "All fields are required"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .systemRed
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return label
    }()
    
    lazy var loginStack = UIStackView(arrangedSubviews: [UIView(), titleLabel, emailField, passwordField, forgotPass, continueButton, continueWithApple, continueWithGoogle, dontHaveAnAcc, registerButton, UIView()], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
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
        loginStack.addSubview(errorMessage)
        }
        else {
            show(YambViewController(), sender: self)
        }
    }
    
    @objc func onRegister(_ sender: UIButton) {
        show(RegisterViewController(), sender: self)
    }
    
}
