//
//  EditUserView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/18/23.
//

import SwiftUI

struct EditUserView: View {
    @State  var user: User
    @EnvironmentObject var userModel: UserModel
//    @State private var firstName: String = ""
//    @State private var lastName: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var phone: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var errorMessage = ""
    //init(user: User ) {
 //       _user = State(initialValue: user)
//        self.firstName = user.firstName
//        self.lastName = lastName
//        self.email = email
//        self.password = password
//        self.phone = phone
        
    //}
    var body: some View {
        Form {
            
            TextField("FirstName", text: $user.firstName)
            TextField("LastName", text: $user.lastName)
            TextField("Email", text: $user.email)
            SecureField("Password", text: $user.password)
            TextField("Phone", text: $user.phone)
                
                Text(errorMessage)
                .foregroundColor(Color.red)
    
            
        }
        .navigationTitle("Update User")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    updateUser()
                }
                .disabled(isFormNotValid)
            }
        }
    }
    var isFormNotValid: Bool {
        user.firstName.isEmpty || user.lastName.isEmpty || user.email.isEmpty || user.password.isEmpty || user.phone.isEmpty
    }
    func updateUser() {
//        let user = User(id: 6 ,firstName: firstName, lastName: lastName, email: email, password: password, phone: phone, dateCreated: Date().displayFormat, createdBy: firstName, dateModified: Date().displayFormat, modifiedBy: firstName, lastLoginDate: "", isActive: true)
        user.dateModified = Date().displayFormat
        user.modifiedBy = user.firstName
        
        Task {
            do {
                try await userModel.updateUser(user)
                if errorMessage.isEmpty {
                    dismiss()
                }
            } catch {
                errorMessage = "error in updating user"
            }
        }
    }
}

//struct EditUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditUserView()
//    }
//}
