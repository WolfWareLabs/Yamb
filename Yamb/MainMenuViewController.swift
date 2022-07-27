//
//  MainMenuViewController.swift
//  Yamb
//
//  Created by Marko on 7/27/22.
//

import UIKit
import SwiftUI

class MainMenuViewController: UIViewController, PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreview {
            let vc = MainMenuViewController()
            return vc
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Yamb"
        label.font = .systemFont(ofSize: 52, weight: .bold)
        label.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        return label
    }()
    
    lazy var newGameButton: UIButton = {
        let button = CustomLoginButton(NSLocalizedString("mainmenu.newgame", comment: "New game"))
        
        return button
    }()
    
    lazy var settingsButton: UIButton = {
        let button = CustomLoginButton(NSLocalizedString("mainmenu.settings", comment: "Settings"))
        button.backgroundColor = .black
        
        return button
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [titleLabel, newGameButton, settingsButton],
            spacing: 5,
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .center
        )
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.center.equalTo(view)
        }
        view.backgroundColor = .white
    }
}
