//
//  LoginViewController.swift
//  Yamb
//
//  Created by Ana Peshevska on 19.4.22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = NSLocalizedString("login.screen.title", comment: "login.screen.title")
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    var emailField = CustomLoginTextField(NSLocalizedString("login.textfield.email", comment: "login.textfield.email"))
    
    var passwordField = CustomLoginTextField(NSLocalizedString("login.textfield.password", comment: "login.textfield.password"))
    
    lazy var forgotPass: CustomLoginButton = {
        var button = CustomLoginButton(NSLocalizedString("login.label.forgotpassword", comment: "login.label.forgotpassword"))
        button.backgroundColor = .white
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    lazy var continueButton: CustomLoginButton = {
        var button = CustomLoginButton(NSLocalizedString("login.buttontitle.continue", comment: "login.buttontitle.continue"))
        button.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
        return button
    }()
    
    lazy var continueWithApple: CustomLoginButton = {
        var button = CustomLoginButton(NSLocalizedString("login.buttontitle.continuewithapple", comment: "login.buttontitle.continuewithapple"))
        button.backgroundColor = .black
        return button
    }()
    
    lazy var continueWithGoogle: CustomLoginButton = {
        var button = CustomLoginButton(NSLocalizedString("login.buttontitle.continuewithgoogle", comment: "login.buttontitle.continuewithgoogle"))
        button.backgroundColor = .white
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    lazy var dontHaveAnAcc: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = NSLocalizedString("login.textfield.donthaveanaccount", comment: "login.textfield.donthaveanaccount")
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.snp.makeConstraints { make in
            make.width.equalTo(300)
        }
        return label
    }()
    
    lazy var registerButton: CustomLoginButton = {
        var button = CustomLoginButton(NSLocalizedString("register.screen.title", comment: "register.screen.title"))
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        return button
    }()
    
    var allFieldsRequiredLabel = CustomErrorLabel(NSLocalizedString("login.register.label.allfieldsarerequired", comment: "login.register.label.allfieldsarerequired"))
    
    lazy var loginStack = UIStackView(arrangedSubviews: [UIView(), titleLabel, allFieldsRequiredLabel, emailField, passwordField, forgotPass, continueButton, continueWithApple, continueWithGoogle, dontHaveAnAcc, registerButton, UIView()], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginStack)
        loginStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        view.backgroundColor = .white
    }
    
    @objc func onContinue(_ sender: Any) {
        if emailField.text?.count == 0 || passwordField.text?.count == 0 {
            allFieldsRequiredLabel.isHidden = false
            self.allFieldsRequiredLabel.shake()
        }
        else {
            let email = emailField.text!
            let password = passwordField.text!
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if(authResult != nil) {
                    self.navigationController?.pushViewController(YambViewController(), animated: true)
                }else {
                    let alert = UIAlertController(title: "Error signing in", message: "Invalid username or password", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func onRegister(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
