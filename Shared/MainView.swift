//
//  MainView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 4/29/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let person = viewModel.person {
                    Text("Hi \(person.name)")
                    Button("Remove", action: remove)
                } else {
                    Text("Who are you?")
                    Button("Add", action: add)
                }
                Spacer()
            }
            .navigationTitle("Main Screen")
            .padding(.top, 20)
        }
    }
    
    private func add() {
        viewModel.add()
    }
    
    private func remove() {
        viewModel.remove()
    }
    
}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
