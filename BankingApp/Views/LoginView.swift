//
//  LoginView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/7/22.
//

import SwiftUI

struct LoginView: View {
    @State private var userName = ""
    @State private var password = ""
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            TextField("UserName", text: $userName)
            SecureField("Password", text: $password)
            
            Button {
                if loginViewModel.isValidLogin(userName: userName, password: password)  {
                    //UserDefaults.standard.set("Test", forKey: "loginInfo")
                    loginViewModel.loginInfo = "Test"
                }
                loginViewModel.userName = userName
                loginViewModel.password = password
                Task {
                    await loginViewModel.login()
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(loginViewModel.isAuthenticated ? "Singout" : "Login")
            }
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
