//
//  PersonsView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct PersonsView: View {
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        ScrollView {
            ForEach(dataManager.persons) { person in
                Button(action: { choose(person: person) }, label: { Text(person.name) } )
                    .padding(5)
            }
            .border(Color.black)
        }
    }
    
}

// MARK: - extension

extension PersonsView {

    private func choose(person: Person) {
    }
    
}

// MARK: - previews

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonsView()
                .environmentObject(DataManager.shared)
        }
    }
}
