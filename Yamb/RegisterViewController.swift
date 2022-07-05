//
//  RegisterViewController.swift
//  Yamb
//
//  Created by Ana Peshevska on 1.7.22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Register"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        return label
    }()
    
    lazy var nameField: CustomLoginTextField = {
        var nameField = CustomLoginTextField()
        nameField.placeholder = "Name"
        return nameField
    }()
    
    lazy var surnameField: CustomLoginTextField = {
        var surnameField = CustomLoginTextField()
        surnameField.placeholder = "Surname"
        return surnameField
    }()
    
    lazy var emailField: CustomLoginTextField = {
        var emailField = CustomLoginTextField()
        emailField.placeholder = "Email Address"
        return emailField
    }()
    
    lazy var passwordField: CustomLoginTextField = {
        var passField = CustomLoginTextField()
        passField.placeholder = "Password"
        passField.isSecureTextEntry = true
        return passField
    }()
    
    lazy var confirmPasswordField: CustomLoginTextField = {
        var passField = CustomLoginTextField()
        passField.placeholder = "Confirm password"
        passField.isSecureTextEntry = true
        return passField
    }()
    
    lazy var registerButton: CustomLoginButton = {
        var button = CustomLoginButton()
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var allFieldsRequired: CustomErrorLabel = {
        var label = CustomErrorLabel()
        label.text = "All fields are required"
        return label
    }()
    
    lazy var passwordsDontMatch: CustomErrorLabel = {
        var label = CustomErrorLabel()
        label.text = "Passwords don't match"
        return label
    }()
    
    lazy var registerStackView = UIStackView(arrangedSubviews: [UIView(), titleLabel, allFieldsRequired, passwordsDontMatch, nameField, surnameField, emailField, passwordField, confirmPasswordField, registerButton, UIView()], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
    @objc func onRegister(_ sender: UIButton){
        if emailField.text?.count == 0 || passwordField.text?.count == 0 {
            allFieldsRequired.isHidden = false
        }
        else if passwordField.text != confirmPasswordField.text {
            passwordsDontMatch.isHidden = false
        }
        else {
            show(YambViewController(), sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(registerStackView)
        registerStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        view.backgroundColor = .white
    }
    
}
