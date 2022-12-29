//
//  LoginViewModel.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/7/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginInfo = ""
    @Published var isAuthenticated = false
    var userName: String = ""
    var password: String = ""
    
    init() {}
    func isValidLogin(userName: String, password: String) -> Bool {
        return  userName.lowercased() == "test" && password == "test" ? true : false
    }
    
    func login() {
        //johndoe, password: password123
//        Webservice().login(userName: userName, password: password) { result in
//            switch result {
//            case .success(let token):
//                print(token)
//                UserDefaults.standard.setValue(token, forKey: "token")
//                //@MainActor.Task {
//                DispatchQueue.main.async {
//                    self.isAuthenticated = true
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//
//            }
//
//        }
        Task {
            do {
                let token = try await Webservice().login(userName: userName, password: password)
                UserDefaults.standard.setValue(token, forKey: "token")
                await MainActor.run {
                    self.isAuthenticated = true
                    self.loginInfo = "Test"
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
