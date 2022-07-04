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
    
    lazy var nameField: UITextField = {
        var nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return nameField
    }()
    
    lazy var surnameField: UITextField = {
        var surnameField = UITextField()
        surnameField.placeholder = "Surname"
        surnameField.layer.borderWidth = 1
        surnameField.layer.borderColor = UIColor.black.cgColor
        surnameField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return surnameField
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
    
    lazy var confirmPasswordField: UITextField = {
        var passField = UITextField()
        passField.placeholder = "Confirm password"
        passField.layer.borderWidth = 1
        passField.layer.borderColor = UIColor.black.cgColor
        passField.isSecureTextEntry = true
        passField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return passField
    }()
    
    lazy var registerButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return button
    }()
    
    lazy var allFieldsRequired: UILabel = {
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
    
    lazy var passwordsDontMatch: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Passwords don't match"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .systemRed
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        return label
    }()
    
    lazy var registerStackView = UIStackView(arrangedSubviews: [UIView(), titleLabel, nameField, surnameField, emailField, passwordField, confirmPasswordField, registerButton, UIView()], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
    @objc func onRegister(_ sender: UIButton){
        if emailField.text?.count == 0 || passwordField.text?.count == 0 {
        registerStackView.addSubview(allFieldsRequired)
        }
        else if passwordField.text != confirmPasswordField.text {
            registerStackView.addSubview(passwordsDontMatch)
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
