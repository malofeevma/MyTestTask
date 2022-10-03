//
//  UserDefaultsManager.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 10/3/22.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKeys: String {
        case users
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        } set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(firstName: String, lastName: String, phone: String, email: String, password: String, age: Date) {
        let user = User(firstName: firstName, lastName: lastName, phone: phone, email: email, password: password, age: age)
        users.insert(user, at: 0)
    }
}