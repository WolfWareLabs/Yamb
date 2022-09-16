//
//  RegisterViewController.swift
//  Yamb
//
//  Created by Ana Peshevska on 1.7.22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = NSLocalizedString("register.screen.title", comment: "register.screen.title")
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.snp.makeConstraints { make in
            make.width.equalTo(300)
        }
        return label
    }()
    
    var nameField = CustomLoginTextField(NSLocalizedString("register.textfield.name", comment: "register.textfield.name"))
    
    var surnameField = CustomLoginTextField(NSLocalizedString("register.textfield.surname", comment: "register.textfield.surname"))
    
    var emailField = CustomLoginTextField(NSLocalizedString("login.textfield.email", comment: "login.textfield.email"))
    
    var passwordField = CustomLoginTextField(NSLocalizedString("login.textfield.password", comment: "login.textfield.password"))
    
    var confirmPasswordField = CustomLoginTextField(NSLocalizedString("register.textfield.confirmpassword", comment: "register.textfield.confirmpassword"))
    
    lazy var registerButton: CustomLoginButton = {
        var button = CustomLoginButton(NSLocalizedString("register.screen.title", comment: "register.screen.title"))
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        return button
    }()
    
    var allFieldsRequiredLabel = CustomErrorLabel(NSLocalizedString("login.register.label.allfieldsarerequired", comment: "login.register.label.allfieldsarerequired"))
    
    var passwordsDontMatchLabel = CustomErrorLabel(NSLocalizedString("register.passwordsdontmatch", comment: "register.passwordsdontmatch"))
    
    lazy var registerStackView = UIStackView(arrangedSubviews: [UIView(), titleLabel, allFieldsRequiredLabel, passwordsDontMatchLabel, nameField, surnameField, emailField, passwordField, confirmPasswordField, registerButton, UIView()], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
    @objc func onRegister(_ sender: Any){
        if emailField.text?.count == 0 || passwordField.text?.count == 0 {
            allFieldsRequiredLabel.isHidden = false
            self.allFieldsRequiredLabel.shake()
        }
        else if passwordField.text != confirmPasswordField.text {
            passwordsDontMatchLabel.isHidden = false
            self.passwordsDontMatchLabel.shake()
        }
        else {
            let email = emailField.text!
            let password = passwordField.text!
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if(authResult != nil) {
                    self.navigationController?.pushViewController(YambViewController(), animated: true)
                } else {
                    let alert = UIAlertController(title: "Error creating user", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
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
