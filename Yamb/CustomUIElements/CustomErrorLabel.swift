//
//  CustomErrorLabel.swift
//  Yamb
//
//  Created by Ana Peshevska on 5.7.22.
//

import UIKit

class CustomErrorLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 25, weight: .semibold)
        self.textColor = .systemRed
        self.isHidden = true
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
