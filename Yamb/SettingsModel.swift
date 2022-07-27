//
//  SettingsModel.swift
//  Yamb
//
//  Created by Marko on 7/27/22.
//

import Foundation

class SettingsModel {
    func get(_ setting: YambSetting) -> Bool {
        return UserDefaults.standard.bool(forKey: setting.rawValue)
    }
    
    func set(_ setting: YambSetting, value: Bool) {
        UserDefaults.standard.set(value, forKey: setting.rawValue)
    }
}
