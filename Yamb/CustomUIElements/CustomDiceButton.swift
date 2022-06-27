//
//  CustomDiceButton.swift
//  Yamb
//
//  Created by Ana Peshevska on 27.6.22.
//

import UIKit

struct CustomButtonViewModel {
    let buttonImage: String
}

class CustomDiceButton: UIButton {
    public let buttonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    var viewModel: CustomButtonViewModel

    init(with viewModel: CustomButtonViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)

        addSubview(buttonImage)
        self.snp.makeConstraints {make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        buttonImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonImage.image = UIImage(named: viewModel.buttonImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

