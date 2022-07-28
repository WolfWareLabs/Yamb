//
//  YambSettings.swift
//  Yamb
//
//  Created by Marko on 7/28/22.
//

import Foundation

class YambSettings {
    var extraColumns = SettingPair(name: "settings.extraColumns", value: false)
    var superYamb = SettingPair(name: "settings.superYamb", value: false)
    
    var allSettings: [SettingPair] {
        [extraColumns, superYamb]
    }
    
    init() {
        loadDefaults()
    }
    
    func loadDefaults() {
        for setting in allSettings {
            setting.value = UserDefaults.standard.bool(forKey: setting.name)
        }
    }
    
    func storeDefaults() {
        for setting in allSettings {
            UserDefaults.standard.set(setting.value, forKey: setting.name)
        }
    }
}
