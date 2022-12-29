//
//  HomeView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/3/22.
//

import SwiftUI

struct HomeView: View {
    @State private var principalAmount = ""
    @State private var interestAmount = ""
    @State private var numOfYears = ""
    @State private var totalAmount = ""
    @State private var isValid = false
    var body: some View {
        
        Form {
            Section {
                TextField("Principal Amount", text: $principalAmount)
            } header: {
                Text("Enter Principal Amount")
            }
            
            Section {
                TextField("Interest Amount", text: $interestAmount)
            } header: {
                Text("Enter Rate of Interest")
            }
            Section {
                TextField("Number of Years", text: $numOfYears)
            } header: {
                Text("Enter Number of Years")
            }
            Section {
                VStack {
                    Text("Calculated Amount: \(totalAmount)")
                    Button {
                        if principalAmount == "" || interestAmount == "" || numOfYears == "" {
                            isValid = true
                        }
                        else {
                            isValid = false
                            
                            totalAmount =   String(format: "%.2f", calculateInterest())
                            
                        }
                    } label: {
                        Text("Calculate")
                    }
                    .alert("Form Validation", isPresented: $isValid) {
                        
                    } message: {
                        Text("Required fields are missing")
                    }
                    
                }

                


            } header: {
                Text("Results")
            }
        }
    }
    
    func calculateInterest()  -> Double {
        return (Double(principalAmount) ?? 0.0) * (Double(interestAmount) ?? 0.0) * (Double(numOfYears) ?? 0.0) / 100
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
