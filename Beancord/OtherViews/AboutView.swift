//
//  AboutView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/18/2021.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("About Beancord")
                    .font(.largeTitle)
                
                Text("Beancord is a simple and easy to use chatting app made for iOS and iPadOS. Beancord was made as a fun hobby project which was about to be abandoned a day after it's creation began.")
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack {
                Text("About the Developer")
                    .font(.largeTitle)
                
                Text("Rehatbir Singh is a student studying in the UAE. He is a hobby-ist programmer who codes in Swift, Python and C++.")
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
