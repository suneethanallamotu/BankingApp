//
//  CreateUserRequest.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/3/23.
//

import Foundation

struct CreateUserRequest: Codable, Hashable {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let phone: String
    var userTypeId: Int
    let dateCreated: String
    let createdBy: String
    let dateModified: String? //Date?
    let modifiedBy: String?
    let lastLoginDate: String? //Date?
    let isActive: Bool
}
