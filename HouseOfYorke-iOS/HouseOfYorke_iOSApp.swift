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

    @StateObject private var repository = Repository.shared
    
    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(repository)
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
    
}
