//
//  UserModel.swift
//  Yamb
//
//  Created by Ana Peshevska on 14.10.22.
//

import Foundation
import UIKit

struct UserModel: Codable {
    var email: String
    var name: String
    var surname: String
    var profilePicture: Image?
    
    init(email: String, name: String, surname: String, profilePicture: Image?) {
        self.email = email
        self.name = name
        self.surname = surname
        self.profilePicture = profilePicture
    }
}
