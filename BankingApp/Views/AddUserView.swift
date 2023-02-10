//
//  AddUserView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/3/23.
//

import SwiftUI

struct AddUserView: View {
    @EnvironmentObject var userModel: UserModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phone: String = ""
    @State private var userTypeId: Int = 3
    @State private var selectedUserType: UserType?
    
    @State private var errorMessage = ""
    @Environment(\.dismiss) var dismissAction
    
    var body: some View {
        Form {
            
                TextField("FirstName", text: $firstName)
                TextField("LastName", text: $lastName)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                TextField("Phone", text: $phone)
                Picker("User Types", selection: $selectedUserType) {
                    ForEach(userModel.userTypes, id: \.id){ userType in
                        Text(userType.typeDescription)
                        
                    }
                }
//                .pickerStyle(.wheel)
                
                Text(errorMessage)
                .foregroundColor(Color.red)
    
            
        }
        .onAppear {
            selectedUserType = userModel.userTypes.first
        }
        .navigationTitle("Add User")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel") {
                    dismissAction()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    addUser()
                }
                .disabled(isFormNotValid)
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading){
//                Button("Cancel") {
//                    dismiss()
//                }
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Register") {
//                    addUser()
//                }
//                .disabled(isFormNotValid)
//            }
//        }
    }
    
    var isFormNotValid: Bool {
        firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty
    }
    func addUser() {
        //let fullName = "\(firstName) \(lastName)"
        let user = CreateUserRequest(firstName: firstName, lastName: lastName, email: email, password: password, phone: phone, userTypeId: userTypeId, dateCreated: Date().displayFormat, createdBy: firstName, dateModified: "", modifiedBy: "", lastLoginDate: "", isActive: true)
        Task {
            do {
                try await userModel.addUser(user)
                if errorMessage.isEmpty {
                    dismissAction()
                }
            } catch {
                errorMessage = "Error in registering a new user."
            }
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        let userModel = UserModel()
        
        return
        NavigationStack{
            AddUserView().environmentObject(userModel)
        }
    }
}
