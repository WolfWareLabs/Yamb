//
//  CustomLoginButton.swift
//  Yamb
//
//  Created by Ana Peshevska on 5.7.22.
//

import UIKit

let cornerRadius = 5

class CustomLoginButton: UIButton {
    init(_ buttonTitle: String) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.setTitle(buttonTitle, for: .normal)
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
