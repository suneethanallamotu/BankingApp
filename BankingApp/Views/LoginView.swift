//
//  LoginView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/7/22.
//

import SwiftUI

struct LoginView: View {
    @State private var email = "suneetha_n@hotmail.com"
    @State private var password = "suneetha"
    @State private var errorMessage = ""
    @State private var isUserAddPresented = false
    
    @EnvironmentObject private var userModel: UserModel
    
    //@ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var isFormNotValid: Bool {
        email.isEmpty || password.isEmpty
    }
    
    var body: some View {
        VStack {
            TextField("UserName", text: $email)
            SecureField("Password", text: $password)
            Text(errorMessage)
            
            Button {
                if !isFormNotValid {
                    login()
                }
            } label: {
                Text(userModel.isAuthenticated ? "Singout" : "Login")
            }
            .disabled(isFormNotValid)
            Spacer()
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Register") {
                    isUserAddPresented = true
                }
            }
        }
        
        .sheet(isPresented: $isUserAddPresented) {
            NavigationStack {
                AddUserView()
            }
        }
    }
    private func login(){
        let loginRequestBody = LoginRequestBody(email: email, password: password)
        Task {
            do {
                try await userModel.login(loginRequestBody)
                if errorMessage.isEmpty {
                    dismiss()
                }
            } catch {
                errorMessage = "Invalid Login."
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
