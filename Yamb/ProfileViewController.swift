//
//  ProfileViewController.swift
//  Yamb
//
//  Created by Ana Peshevska on 13.10.22.
//

import UIKit
import Firebase

protocol LogOutDelegate: AnyObject {
    func userDidLogOut()
}

class ProfileViewController: UIViewController {
    
    weak var delegate: LogOutDelegate?
    
    lazy var profilePicture: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        return imageView
    }()
    
    lazy var nameAndSurnameLabel: UILabel = {
        var label = UILabel()
        label.text = "\(StorageManager.userName) \(StorageManager.userSurname)"
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        var label = UILabel()
        label.text = "Email: \(StorageManager.userEmail)"
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    lazy var logOutButton: UIButton = {
       var button = UIButton()
        button.setTitle("Log out", for: .normal)
        button.addTarget(self, action: #selector(onLogOut), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        return button
    }()
    
    lazy var mainStackView = UIStackView(arrangedSubviews: [profilePicture, nameAndSurnameLabel, usernameLabel, scoreLabel , logOutButton], spacing: 10, axis: .vertical, distribution: .fill, alignment: .center)
    
    @objc func onLogOut() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            StorageManager.userEmail = ""
            self.dismiss(animated: true)
            delegate?.userDidLogOut()
        } catch let error {
            let alert = UIAlertController(title: "Error signing out", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(400)
        }
    }
}

