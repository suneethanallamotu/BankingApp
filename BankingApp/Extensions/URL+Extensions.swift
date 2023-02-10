//
//  URL+Extensions.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/29/22.
//

import Foundation

extension URL {
    static var development: URL {
        URL(string: "https://lvstechwebapi.azurewebsites.net/")!
    }
    
    static var production: URL {
        URL(string: "https://lvstechwebapi.azurewebsites.net/")!
    }
    
    static var baseURL: URL {
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    
    static var authenticateUser: URL {
        return URL(string: "api/authentication/authenticate", relativeTo: Self.baseURL)!
    }
    static var getUsers: URL {
        return URL(string: "api/users", relativeTo: Self.baseURL)!
    }
    static var addUser: URL {
        return URL(fileURLWithPath: "api/users", relativeTo: Self.baseURL)
    }
    static func updateUser(id: Int) -> URL {
        return URL(fileURLWithPath: "api/users/\(id)", relativeTo: Self.baseURL)
    }
    static func deleteUser(id: Int) -> URL {
        return URL(fileURLWithPath: "api/users/\(id)", relativeTo: Self.baseURL)
    }
    
    // MARK: Get all UserTypes
    static var getUserTypes: URL {
        return URL(string: "api/usertypes", relativeTo: Self.baseURL)!
    }
}
