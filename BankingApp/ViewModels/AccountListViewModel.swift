//
//  AccountListViewModel.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/11/22.
//

import Foundation

class AccountListViewModel: ObservableObject {
    @Published var accounts: [Account] = []
    
    func getAllAcccounts() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "token") else {
            return
        }
        Webservice().getAllAccounts(token: token) { result in
            switch result {
            case .success(let accounts):
                print(accounts)
                DispatchQueue.main.async {
                    self.accounts = accounts
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
