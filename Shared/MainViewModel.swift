//
//  MainViewModel.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import SwiftUI

extension MainView {
    
    class ViewModel: ObservableObject {

        @AppStorage("currentPerson") private var currentPerson: Data = Data()
        @Published var person: Person?

        init() {
            Task {
                await person = getCurrentPerson()
            }
        }
        
        private func getCurrentPerson() async -> Person? {
            let person = try? JSONDecoder().decode(Person.self, from: currentPerson)
            return person
        }

        private func save() async {
            if let personData = try? JSONEncoder().encode(person) {
                currentPerson = personData
            }
        }
        
        func add() {
            Task {
                person = Person(name: "Bruce", admin: false, parent: false)
                await save()
            }
        }
        
        func remove() {
            currentPerson = Data()
            person = nil
        }
        
    }
    
}
