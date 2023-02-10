//
//  User.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/29/22.
//

import Foundation

struct User: Codable, Hashable {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var phone: String
    var userTypeId: Int
    var dateCreated: String
    var createdBy: String
    var dateModified: String? //Date?
    var modifiedBy: String?
    var lastLoginDate: String? //Date?
    var isActive: Bool
    
    
//    enum CodingKeys: String, CodingKey {
//      case id, firstName, lastName, email, password, phone, dateCreated, createdBy, dateModified, modifiedBy, lastLoginDate, isActive
//
//    }
    
//     init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.firstName = try container.decode(String.self, forKey: .firstName)
//        self.lastName  = try container.decode(String.self, forKey: .lastName)
//        self.email = try container.decode(String.self, forKey: .email)
//        self.password = try container.decode(String.self, forKey: .password)
//        self.phone = try container.decode(String.self, forKey: .phone)
//        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
//        self.createdBy = try container.decode(String.self, forKey: .createdBy)
//        self.dateModified = try container.decode(String.self, forKey: .dateModified)
//        self.modifiedBy = try container.decode(String.self, forKey: .modifiedBy)
//        self.lastLoginDate = try container.decode(String.self, forKey: .lastLoginDate)
//        self.isActive = try container.decode(Bool.self, forKey: .isActive)
//    }
//    init(id: Int, firstName: String, lastName: String, email: String, password: String, phone: String, dateCreted: Date?, createdBy: String,
//         dateModified: Date?, modifiedBy: String, lastLoginDate: Date?, isActive: Bool) {
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.password = password
//        self.phone = phone
//        self.dateCreated = dateCreated
//        self.createdBy = createdBy
//        self.dateModified = dateModified
//        self.modifiedBy = modifiedBy
//        self.lastLoginDate = lastLoginDate
//        self.isActive = isActive
//    }

//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        try container.encode(id, forKey: .id)
//        try container.encode(firstName, forKey: .firstName)
//        try container.encode(lastName, forKey: .lastName)
//        try container.encode(email, forKey: .email)
//        try container.encode(password, forKey: .password)
//        try container.encode(phone, forKey: .phone)
//        try container.encode(dateCreated, forKey: .dateCreated)
//        try container.encode(createdBy, forKey: .createdBy)
//        try container.encode(dateModified, forKey: .dateModified)
//        try container.encode(modifiedBy, forKey: .modifiedBy)
//        try container.encode(lastLoginDate, forKey: .lastLoginDate)
//        try container.encode(isActive forKey: .isActive)
//    }
    
}

extension User {
    static func defaultUser() -> User {
        let user = User(id: 0, firstName: "", lastName: "", email: "", password: "", phone: "", userTypeId: 3, dateCreated: "", createdBy: "", dateModified: "", modifiedBy: "", lastLoginDate: "", isActive: false)
        
        return user
    }
}
