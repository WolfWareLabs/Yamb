//
//  CustomErrorLabel.swift
//  Yamb
//
//  Created by Ana Peshevska on 5.7.22.
//

import UIKit

class CustomErrorLabel: UILabel {
    
    init(_ label: String) {
        super.init(frame: .zero)
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 20, weight: .semibold)
        self.textColor = .systemRed
        self.isHidden = true
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.text = label
        self.snp.makeConstraints { make in
            make.width.equalTo(300)
            //make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
