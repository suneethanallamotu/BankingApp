//
//  SettingsView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/3/22.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @StateObject var accountListVM = AccountListViewModel()
    //@State var loginInfo = UserDefaults.standard.string(forKey: "loginInfo")
    
    var body: some View {
//        Text("Settings View")
        NavigationView {
            Form {
                Section {
                    if loginViewModel.loginInfo.isEmpty {
                        NavigationLink(destination: LoginView(loginViewModel: loginViewModel)) {
                            Text("Login")
                        }
                    }
                    else {
                        
                        VStack {
                            Text("Welcome: \(loginViewModel.loginInfo)")
                            if loginViewModel.isAuthenticated && accountListVM.accounts.count > 0 {
                                List(accountListVM.accounts, id: \.id) { account in
                                    HStack {
                                        Text("\(account.name)")
                                        Spacer()
                                        Text(String(format: "%.2f", account.balance))
                                    }
                                }.listStyle(PlainListStyle())
                            } else {
                                Text("Login to see your accounts.")
                            }
                            Button {
                                accountListVM.getAllAcccounts()
                            } label: {
                                Text("Get all Accounts")
                            }
                        }

                    }
                } header: {
                    Text("Login Info")
                    
                }
                
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
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(loginViewModel: <#T##LoginViewModel#>())
//    }
//}
