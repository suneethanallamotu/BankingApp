//
//  UserModel.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/29/22.
//

import Foundation
@MainActor
class UserModel: ObservableObject {
    
    let client = HTTPClient()
    //@Published var loginInfo = ""
    @Published var isAuthenticated = false
    @Published var token: String = ""

    @Published var user: User = User.defaultUser()
//    User(id: 0, firstName: "", lastName: "", email: "", password: "", phone: "", userTypeId: 3, dateCreated: "", createdBy: "", dateModified: "", modifiedBy: "", lastLoginDate: "", isActive: false)
    @Published var users: [User] = []
    @Published var userTypes: [UserType] = []
    
    func login(_ loginRequestBody: LoginRequestBody) async throws {
        
        let data = try JSONEncoder().encode(loginRequestBody)
        let loginResponse: LoginResponse = try await client.load(Resource(url: URL.authenticateUser, method: .post(data)))
        UserDefaults.standard.setValue(loginResponse.token, forKey: "token")
        isAuthenticated = true
        token = loginResponse.token
        //loginInfo = "Welcome \(loginRequestBody.email)!"
        user = loginResponse.user
    }
    func getUsers() async throws {
        if let token = UserDefaults.standard.string(forKey: "token") {
            users = try await client.load(Resource(url: URL.getUsers, headers:["Authorization": "Bearer \(token)"]))
        }
        else {
            users = try await client.load(Resource(url: URL.getUsers))
        }
    }
    
    func addUser(_ createUserRequest: CreateUserRequest) async throws {
        let data = try JSONEncoder().encode(createUserRequest)
        let user: CreateUserRequest = try await client.load(Resource(url: .getUsers, method: .post(data)))
    }
    func updateUser(_ user: User) async throws {
        let data = try JSONEncoder().encode(user)
        if let token = UserDefaults.standard.string(forKey: "token") {
            let user: User = try await client.load(Resource(url: URL.updateUser(id: user.id), headers: ["Authorization" : "Bearer \(token)"], method:    .put(data)))
        }
    }
    func deleteUser(user: User) async throws {
        //let data = try JSONEncoder().encode(user)
        if let token = UserDefaults.standard.string(forKey: "token") {
//            let queryItem = URLQueryItem(name: "id", value: "\(user.id)")
//            let user: String = try await client.load(Resource(url: URL.deleteUser(id: user.id), headers: ["Authorization" : "Bearer \(token)"], method: .delete([queryItem])))
            
            let user: String = try await client.load(Resource(url: URL.deleteUser(id: user.id), headers: ["Authorization" : "Bearer \(token)"], method: .delete))
        }
        print(user)
    }
   
    func logout(){
        UserDefaults.standard.setValue("", forKey: "token")
        isAuthenticated = false
        token = ""
    }
    
    // MARK: USER TYPES
    
    func getUserTypes() async throws {
        userTypes = try await client.load(Resource(url: URL.getUserTypes))
    }
}
