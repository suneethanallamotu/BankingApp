//
//  LoginResponse.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/2/23.
//

import Foundation

struct LoginResponse: Codable {
    var token: String
    var user: User
    
}
