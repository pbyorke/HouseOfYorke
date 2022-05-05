//
//  HouseOfYorke_iOSApp.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/30/22.
//
// https://www.youtube.com/watch?v=qKL5jJGi_HI
// https://github.com/firebase/firebase-ios-sdk
//

import SwiftUI
import Firebase

@main
struct HouseOfYorke_iOSApp: App {

    @StateObject private var dataManager = DataManager.shared
    
    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .environmentObject(dataManager)
            }
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
    
}
