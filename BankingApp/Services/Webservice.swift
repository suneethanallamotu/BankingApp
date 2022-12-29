//
//  Webservice.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/9/22.
//

import Foundation
import SwiftUI

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let userName: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}
//struct Account: Decodable {
//    
//}
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case noData
    case decodingError
}
class Webservice {
    //old way
//    func login(userName: String, password: String, completion: @escaping(Result<String, AuthenticationError>) -> Void) {
//        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/login") else { return }
//        let body = LoginRequestBody(userName: userName, password: password)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONEncoder().encode(body)
//
//        URLSession.shared.dataTask(with: request) { data,response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
//                return
//            }
//            guard let token = loginResponse.token else {
//                return
//            }
//            completion(.success(token))
//        }.resume()
//    }
    
//    func login(userName: String, password: String) async throws -> String {
//        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/login") else { return "" }
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode(String.self, from: data) //.data
//    }
    //let configuration = URLSessionConfiguration.default
    //let session = URLSession(configuration: configuration)
    func login(userName: String, password: String) async throws -> String {
        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/login") else { throw NetworkError.invalidURL }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        //Task {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.requestFailed
            }
            guard let decodedData = try? JSONDecoder().decode(String.self, from: data) else {
                throw NetworkError.decodingError
            }
            
                //return decodedData
           
        //}
        return decodedData
    }
    
    func getAllAccounts(token: String, completion: @escaping(Result<[Account], NetworkError>) -> Void) {
        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/accounts") else {
            completion(.failure(.invalidURL))
            return
            
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
            
        }.resume()
    }
}
