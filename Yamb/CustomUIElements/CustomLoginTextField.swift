//
//  CustomLoginTextField.swift
//  Yamb
//
//  Created by Ana Peshevska on 5.7.22.
//

import UIKit

class CustomLoginTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
