//
//  CompanyView.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/3/22.
//

import SwiftUI
import AVKit


struct CompanyView: View {
    //@ObservedObject var webViewModel = WebViewModel(url: //"https://www.youtube.com/watch?v=SxpK-rzYSXg")

    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "person.fill")
                    Text("Welcome Suneetha")
                }
            } header: {
                Text("User Info")
            }
            
            Section {
                Image("onBoard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } header: {
                Text("Company Logo")
            }
            
            Section {
                VideoPlayer(player: AVPlayer(url: URL(string: "https://bit.ly/swswift")!))
                    .frame(width: 400, height: 300)
                //https://www.youtube.com/watch?v=SxpK-rzYSXg
                //https://www.youtube.com/watch?v=SxpK-rzYSXg
//                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "video", withExtension: ".mp4")!))
            } header: {
                Text("More Info")
            }


        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView()
    }
}
