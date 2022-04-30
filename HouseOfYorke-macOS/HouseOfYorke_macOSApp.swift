//
//  HouseOfYorke_macOSApp.swift
//  HouseOfYorke-macOS
//
//  Created by Peter Yorke on 4/30/22.
//
// https://www.youtube.com/watch?v=qKL5jJGi_HI
// https://github.com/firebase/firebase-ios-sdk
//

import SwiftUI
import Firebase

@main
struct HouseOfYorke_macOSApp: App {
    
    @StateObject private var families = Families.shared

    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(families)
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
    
}
