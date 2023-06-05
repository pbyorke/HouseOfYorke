//
//  HouseOfYorkeApp.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/3/23.
//
// TODO
//    tvOS icon
//    Done when in update mode only goes back one screen
//    watchOS version

import SwiftUI
import Firebase

@main
struct HouseOfYorkeApp: App {
    
    @StateObject private var vm = ViewModel()

    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color(.white))
                .environmentObject(vm)
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
    
}
