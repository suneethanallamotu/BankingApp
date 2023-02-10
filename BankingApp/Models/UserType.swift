//
//  UserType.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/24/23.
//

import Foundation

struct UserType: Codable, Hashable {
    let id: Int
    let typeDescription: String
    let isActive: Bool
}
