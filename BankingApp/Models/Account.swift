//
//  Account.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/9/22.
//

import Foundation
struct Account: Decodable {
    var id = UUID()
    var name: String
    var balance: Double
}
