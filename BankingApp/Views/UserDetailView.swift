//
//  UserDetailView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/3/23.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    @State private var editMode = false
    
    var body: some View {
        VStack(alignment: .leading) {
           
            HStack(alignment: .firstTextBaseline) {
                Text("\(user.firstName) \(user.lastName)")
                    .bold()
                Spacer()
            }
            Text(user.email)
            Text(user.phone)
            //Text("IsActive: \(user.isActive)")
            Spacer()
          
           
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    editMode = true
                } label: {
                    Text("Edit")
                }

            }
        }
        .padding()
        .sheet(isPresented: $editMode) {
            NavigationStack {
                EditUserView(user: user)
            }
        }
    }
  
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User.defaultUser())
    }
}
