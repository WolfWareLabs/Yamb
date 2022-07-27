//
//  SettingSwitch.swift
//  Yamb
//
//  Created by Marko on 7/27/22.
//

import Foundation
import UIKit

class SettingSwitch: UISwitch {
    let setting: YambSetting
    
    init(_ setting: YambSetting) {
        self.setting = setting
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
