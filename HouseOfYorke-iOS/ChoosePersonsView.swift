//
//  ChoosePersonsView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct ChoosePersonView: View {
    
    @EnvironmentObject private var vm: MainViewModel
    @State private var needPassword = false
    @State private var person: Person?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Choose your name")
                        .font(.largeTitle)
                    Text("(family: \(vm.family?.name ?? ""))")
                        .font(.callout)
                        .padding(.bottom, 20)
                    ForEach(vm.filteredPersons) { person in
                        Button(action: { choose(person: person) }, label: { Text(person.name) } )
                            .font(.title)
                            .padding(5)
                    }
                    if needPassword {
                        PasswordView(person: person ?? Person())
                    }
                }
                if vm.multipleFamilies {
                    Button(action: { goBack() }, label: { Text("Cancel") } )
                }
            }
            .onAppear {
                needPassword = false
                vm.password = ""
            }
        }
    }
}

// MARK: - extension

extension ChoosePersonView {

    private func choose(person: Person) {
        self.person = person
        if person.parent {
            if vm.password.isEmpty {
                needPassword = true
            } else {
                vm.signon(person: person)
            }
        } else {
            vm.signon(person: person)
        }
    }

    private func goBack() {
        vm.signoff()
    }

}

// MARK: - previews

struct ChoosePersonsView_Previews: PreviewProvider {
    @State static private var personChosen = true
    static var previews: some View {
        ChoosePersonView()
            .environmentObject(MainViewModel())
    }
}
