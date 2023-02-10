//
//  HTTPClient.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/29/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case decodingError
    case invalidServerResponse
    case invalidURL
    
}

enum HttpMethod {
    
    case get([URLQueryItem])
    case post(Data?)
    case put(Data?)
    //case delete([URLQueryItem])
    case delete
    
    var name: String {
        switch self {
            
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String] = [:]
    var method: HttpMethod = .get([])
}

class HTTPClient {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.headers
        request.httpMethod = resource.method.name
        
        switch resource.method {
            
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badURL
            }
            request.url = url
            
        case .post(let data):
            request.httpBody = data
        case .put(let data):
            request.httpBody = data
        case .delete:
            break
            //request.httpBody = data
        /*
        case .delete(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badURL
            }
            request.url = url
            //request.httpBody = data
            */
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        // data is empty for successfull delete, so may be return here empty message or return successfully deleted user
        let decoder = JSONDecoder()
        /*let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm a")
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
         
        decoder.dateDecodingStrategy = .formatted(dateFormatter) //.iso8601
        */
        guard let result = try? decoder.decode(T.self, from: data) else {
            //fatalError()
            throw NetworkError.decodingError
        }
       
                
        return result
    }
}


//loginRequest.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "content-type": "application/json",
//  "authorization": "Basic \(encodedString)"
//]
//po String(decoding: data, as: UTF8.self)
