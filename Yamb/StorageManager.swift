//
//  StorageManager.swift
//  Yamb
//
//  Created by v.martin.peshevski on 6.10.22.
//

import Foundation

struct StorageManager {
    
    private static let kUserEmail = "user_email_key"
    private static let kUserName = "user_name_key"
    private static let kUserSurname = "user_surname_key"
    
    @Storage(key: kUserEmail, defaultValue: "")
    static var userEmail: String
    
    @Storage(key: kUserName, defaultValue: "")
    static var userName: String
    
    @Storage(key: kUserSurname, defaultValue: "")
    static var userSurname: String

}

@propertyWrapper
struct Storage {
    private let key: String
    private let defaultValue: String
    
    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: String {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.string(forKey: key) ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
