//
//  BankingAppApp.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/3/22.
//

import SwiftUI

@main
struct BankingAppApp: App {
    @StateObject private var userModel = UserModel()
    var body: some Scene {
        WindowGroup {
            //ContentView()
            MainView()
                .environmentObject(userModel)
        }
    }
}
