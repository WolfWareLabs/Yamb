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
            let vc = SettingsViewController(settingsModel: YambSettings())
            return vc
        }
    }
    
    let cellReuseIdentifier = "cell"
    let model: YambSettings
    
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
    
    init(settingsModel: YambSettings) {
        model = settingsModel
        super.init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        model = YambSettings()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
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
        return model.allSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        let currSetting = model.allSettings[indexPath.row]
        cell.textLabel!.text = NSLocalizedString(currSetting.name, comment: currSetting.name)
        
        let uiSwitch = SettingSwitch(currSetting)
        uiSwitch.setOn(currSetting.value, animated: false)
        uiSwitch.addTarget(self, action: #selector(onSwitchChange), for: .valueChanged)
        
        cell.accessoryView = uiSwitch
        return cell
    }
    
    @objc func onSwitchChange(_ sender: SettingSwitch) {
        sender.setting.value = sender.isOn
        model.storeDefaults()
    }
}
