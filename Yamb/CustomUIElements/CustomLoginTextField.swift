//
//  CustomLoginTextField.swift
//  Yamb
//
//  Created by Ana Peshevska on 5.7.22.
//

import UIKit

class CustomLoginTextField: UITextField {
    
    init(_ placeholder: String) {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.placeholder = placeholder
        if placeholder == NSLocalizedString("login.textfield.email", comment: "login.textfield.email") {
            self.autocapitalizationType = .none
        }
        if placeholder == NSLocalizedString("login.textfield.password", comment: "login.textfield.password") || placeholder == NSLocalizedString("register.textfield.confirmpassword", comment: "register.textfield.confirmpassword") {
            self.isSecureTextEntry = true
            self.autocapitalizationType = .none
        }
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
