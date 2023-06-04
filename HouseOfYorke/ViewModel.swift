//
//  ViewModel.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/3/23.
//

import Foundation

enum PageType {
    case choose
    case person
    case parent
    case password
    case update
}

class ViewModel: ObservableObject {
    
    @Published var allPersons   = [Person]()
    @Published var page         = PageType.choose
    @Published var password     = ""
    @Published var selectedPerson: Person?
    @Published var updatePerson: Person?
    
    private var personManager = PersonDataManager.shared

    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        Task {
            for await value in personManager.$persons.values {
                await MainActor.run(body: {
                    self.allPersons = value
                })
            }
        }
    }
    
    func validate() {
        if let person = selectedPerson {
            if person.password == password {
                page = .parent
            }
        }
    }

    func adjust(_ amount: Int) {
        if let child = updatePerson {
            let newPerson = Person (
                id:         child.id,
                name:       child.name,
                password:   child.password,
                points:     child.points + amount,
                parent:     child.parent
            )
            do {
                try personManager.update(newPerson, collection: .persons)
                updatePerson = newPerson
            } catch { print("\(error.localizedDescription)") }
        }
    }

}
