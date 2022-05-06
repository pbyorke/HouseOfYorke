//
//  ChoosePersonsView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct ChoosePersonView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack {
            Text("Choose your name")
                .foregroundColor(.yellow)
                .font(.title)
                .padding(.bottom, 20)
            ForEach(dataManager.persons) { person in
                Button(action: { choose(person: person) }, label: { Text(person.name) } )
                    .padding(5)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - extension

extension ChoosePersonView {

    private func choose(person: Person) {
        dataManager.person = person
    }

}

// MARK: - previews

struct ChoosePersonsView_Previews: PreviewProvider {
    @State static private var personChosen = true
    static var previews: some View {
        ChoosePersonView()
            .environmentObject(DataManager.shared)
    }
}
