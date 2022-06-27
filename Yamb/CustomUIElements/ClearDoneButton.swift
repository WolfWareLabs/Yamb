//
//  ClearDoneButton.swift
//  Yamb
//
//  Created by Ana Peshevska on 27.6.22.
//

import UIKit

class ClearDoneButton: UIButton {

    init(){
        super.init(frame: .zero)
        self.snp.makeConstraints {make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        self.setTitleColor(.label, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 25)
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
