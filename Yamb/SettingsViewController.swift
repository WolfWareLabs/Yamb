//
//  SettingsViewController.swift
//  Yamb
//
//  Created by Marko on 7/27/22.
//

import Foundation
import UIKit
import SwiftUI

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreview {
            let vc = SettingsViewController()
            return vc
        }
    }
    
    let options = ["settings.extraColumns", "settings.superYamb"]
    let cellReuseIdentifier = "cell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("settings.title", comment: "Settings panel title")
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        return table
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, tableView], spacing: 10, axis: .vertical, distribution: .fill, alignment: .leading)
        return stack;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStack)
        view.backgroundColor = .white
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {make in
            make.left.equalTo(15)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel!.text = NSLocalizedString(options[indexPath.row], comment: options[indexPath.row])
        cell.accessoryView = UISwitch()
        return cell
    }
}
