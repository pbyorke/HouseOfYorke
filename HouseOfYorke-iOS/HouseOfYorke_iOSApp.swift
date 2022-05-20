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

    @StateObject private var vm = MainViewModel()
    
    init() {
        configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(.stack)
            .environmentObject(vm)
        }
    }

    private func configure() {
        FirebaseApp.configure()
    }
    
}
