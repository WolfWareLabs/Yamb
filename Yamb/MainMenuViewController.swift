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
        button.addTarget(self, action: #selector(onNewGame), for: .touchUpInside)
        
        return button
    }()
    
    lazy var settingsButton: UIButton = {
        let button = CustomLoginButton(NSLocalizedString("mainmenu.settings", comment: "Settings"))
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(onSettings), for: .touchUpInside)
        
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
    
    let settings = YambSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.center.equalTo(view)
        }
        view.backgroundColor = .white
    }
    
    @objc func onNewGame(_ sender: Any) {
        show(YambViewController(settings: settings), sender: self)
    }
    
    @objc func onSettings(_ sender: Any) {
        show(SettingsViewController(settingsModel: settings), sender: self)
    }
}
