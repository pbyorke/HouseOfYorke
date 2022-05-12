//
//  ChoosePersonsView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct ChoosePersonView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State private var needPassword = false
    @State private var person: Person?
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Choose your name")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                ForEach(dataManager.persons) { person in
                    Button(action: { choose(person: person) }, label: { Text(person.name) } )
                        .font(.title)
                        .padding(5)
                }
                if needPassword {
                    PasswordView(person: person ?? Person())
                }
            }
            if dataManager.multipleFamilies {
                Button(action: { goBack() }, label: { Text("Cancel") } )
            }
        }
        .onAppear {
            needPassword = false
            dataManager.password = ""
        }
    }
}

// MARK: - extension

extension ChoosePersonView {

    private func choose(person: Person) {
        self.person = person
        if person.parent {
            if dataManager.password.isEmpty {
                needPassword = true
            } else {
                dataManager.person = person
            }
        } else {
            dataManager.person = person
        }
    }

    private func goBack() {
        dataManager.signOff()
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
