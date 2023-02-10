//
//  AuthenticationRequestBody.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/29/22.
//

import Foundation

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    
    enum CodingKeys:  CodingKey {
      case email, password
      
    }
}
