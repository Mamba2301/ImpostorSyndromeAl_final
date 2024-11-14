//
//  ImpostorSyndromeAlApp.swift
//  ImpostorSyndromeAl
//
//  Created by Alessandra Di Rosa on 13/11/24.
//

import SwiftUI

@main
struct ImpostorSyndromeAlApp: App {
    @State private var currentDate: Date = Date()  

    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(Color("AccentColor"))
        }
    }
}
