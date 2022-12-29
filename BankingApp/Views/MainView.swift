//
//  MainView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/3/22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            CompanyView()
                .tabItem {
                    Label("Company", systemImage: "person")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            SettingsView(loginViewModel: loginViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(loginViewModel: LoginViewModel())
    }
}
