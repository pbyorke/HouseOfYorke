//
//  MainView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 4/29/22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var repository: Repository
    
    @StateObject private var viewModel: ViewModel
    
    @State private var familyChosen = false
    @State private var personChosen = false
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                if viewModel.person != nil { // someone is already signed in
                    PersonActionsView()
                } else { // we need to have them sign in
                    // if there is only one family, then tell that to Persons and prompt for Person
                    if repository.oneFamily {
                        ChoosePersonView(personChosen: $personChosen)
                    }
                }
                Spacer()
            }
            .navigationTitle("Main Screen")
            .padding(.top, 20)
        }
    }
    
}

// MARK: - extension

extension MainView {

    private func add() {
        viewModel.add()
    }
    
    private func remove() {
        viewModel.remove()
    }
    
}

// MARK: - previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Repository.shared)
    }
}
