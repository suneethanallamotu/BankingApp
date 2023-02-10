//
//  SettingsView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/3/22.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    //@ObservedObject var loginViewModel: LoginViewModel
    //@StateObject var accountListVM = AccountListViewModel()
    //@State var loginInfo = UserDefaults.standard.string(forKey: "loginInfo")
    @EnvironmentObject private var userModel: UserModel
    @State private var errorMessage: String = ""
    @State private var isUserLogout = false
    var body: some View {
//        Text("Settings View")
        NavigationView {
            Form {
                Section {
                    if userModel.token.isEmpty {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                        }
                    }
                    else {
                        VStack {
                            HStack {
                                Text("Welcome: \(userModel.user.firstName)")
                                
                            }
                            NavigationLink(destination: UserListView()) {
                                Text("Get all Users")
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Log out") {
                                    isUserLogout = true
                                    userModel.logout()
                                }
                            }
                        }
                    }
                } header: {
                    Text("Login Info")
                    
                }
                
//                .sheet(isPresented: $isUserLogout){
//                    NavigationStack {
//
//                    }
//                }
                Section {
                    VStack {
                        Button {
                            UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("request granted")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                        } label: {
                            Text("Request Permission")
                        }
                        Spacer()
                        Button {
                            let content = UNMutableNotificationContent()
                            content.title = "Notification Title"
                            content.subtitle = "sending notifications to user"
                            content.sound = UNNotificationSound.default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            
                        } label: {
                            Text("Schedule Notification")
                        }


                    }
                } header: {
                    Text("Notifications")
                }
                
                
                
            }
            .navigationTitle("Settings")
        }
    }
    
    private func getUsers(){
        Task {
            do {
                try await userModel.getUsers()
                
            } catch {
                errorMessage = "Error getting users."
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(loginViewModel: <#T##LoginViewModel#>())
//    }
//}
