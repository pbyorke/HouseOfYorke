//
//  HouseOfYorke_tvOSApp.swift
//  HouseOfYorke-tvOS
//
//  Created by Peter Yorke on 4/30/22.
//
// https://www.youtube.com/watch?v=qKL5jJGi_HI
// https://github.com/firebase/firebase-ios-sdk
//

import SwiftUI
import Firebase

@main
struct HouseOfYorke_tvOSApp: App {
    
    @StateObject private var dataManager = DataManager.shared
    
    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTVView()
                    .environmentObject(dataManager)
            }
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
    
}
