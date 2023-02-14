//
//  UserListView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/9/23.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject private var userModel: UserModel
    
    @State private var errorMessage = ""
    @MainActor @State private var downloadProgress: Float = 0.0
    @MainActor @State private var isDownloading = false
    
    var body: some View {
                
        //NavigationStack {
            List {
                ForEach(userModel.users, id: \.id) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            Text("\(user.firstName)  \(user.lastName)")
                            Spacer()
                            
                        }
                    }
                }
                .onDelete { indexSet in
                    deleteUser(at: indexSet)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Users")
            .toolbar {
                EditButton()
            }
            .task {
                getUsers()
            }
        if isDownloading {
            //ProgressView(value: downloadProgress)
            ProgressView()
        }
        //}
       
    }
    
    func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = userModel.users[index]
            Task {
                do {
                    try await userModel.deleteUser(user: user)
                } catch {
                    errorMessage = "Error deleting user."
                }
            }
        }
    }
    
    func getUsers() {
        Task {
            do {
                try await userModel.getUsers()
            } catch {
                errorMessage = "Error getting users."
            }
        }
    }
    
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
