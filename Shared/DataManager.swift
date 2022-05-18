//
//  DataManager.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/3/22.
//

import SwiftUI
import FirebaseFirestore

class DataManager: ObservableObject {
    
    let defaultsManager = DefaultsManager()
    
    private var familyListener: ListenerRegistration?
    private var personListener: ListenerRegistration?

    var multipleFamilies: Bool { families.count > 1 }
    var children: [Person] { persons.filter { $0.parent == false } }
    var password = ""
    var name: String { person?.name ?? "" }
    var points: Int { person?.points ?? 0 }
    var parent: Bool { person?.parent ?? false }

    var isSignedIn: Bool {
        return person != nil
    }
    
    var needFamily: Bool {
        if person != nil {
            return false
        }
        return families.count > 1 && family == nil
    }
    
    var needPerson: Bool {
        if person != nil {
            return false
        }
        return family != nil
    }

    @Published var families = [Family]()
    @Published var persons = [Person]()
    @Published var family: Family?
    @Published var person: Person?

    func signon(family: Family) {
        self.family = family
        defaultsManager.setCurrentFamily(family)
    }
    
    func signon(person: Person) {
        self.person = person
        defaultsManager.setCurrentPerson(person)
    }
    
    func signoff() {
        family = nil
        defaultsManager.setCurrentFamily(family)
        person = nil
        defaultsManager.setCurrentPerson(person)
    }

    init() {
        setup()
    }
    
    private func setup() {
        self.family = self.defaultsManager.getCurrentFamily()
        self.person = self.defaultsManager.getCurrentPerson()
        setupFamilies()
        setupPersons()
    }
    
    private func setupFamilies() {
        familyListener = FirestoreType.reference(to: .families).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    do {
                        var array: [Family] = []
                        for document in snapshot.documents {
                            let entry = try document.decode(as: Family.self, includingId: true)
                            array.append(entry)
                        }
                        // do whatever
                        self.families = array
                        if self.families.count == 1 {
                            self.family = self.families[0]
                        }
                        // do whatever
                    } catch { }
                }
            }
        }
    }

    private func setupPersons() {
        personListener = FirestoreType.reference(to: .persons).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    do {
                        var array: [Person] = []
                        for document in snapshot.documents {
                            let entry = try document.decode(as: Person.self, includingId: true)
                            array.append(entry)
                        }
                        // do whatever
                        var filteredArray: [Person] = []
                        if self.family != nil {
                            for item in array {
                                if item.familyID == self.family!.id {
                                    filteredArray.append(item)
                                }
                            }
                        }
                        self.persons = filteredArray
                        // do whatever
                    } catch { }
                }
            }
        }
    }

    func adjust(_ child: Person, _ amount: Int) {
        let newPerson = Person (
            id: child.id,
            name: child.name,
            photoURL: child.photoURL,
            familyID: child.familyID,
            parent: child.parent,
            points: child.points + amount
        )
        do {
            try update(newPerson, collection: .persons)
        } catch { print("* * *  \(error.localizedDescription)") }
    }
    
    func zero(_ child: Person) {
        let amount = child.points * -1
        adjust(child, amount)
    }
    
    private func update<T: Encodable & Identifiable>(_ object: T, collection: FirestoreType) throws {
        do {
            let json = try object.toJson(excluding: ["id"])
            let id = "\(object.id)"
            FirestoreType.reference(to: collection).document(id).setData(json)
        } catch {
            throw FirebaseError.namedError(error.localizedDescription)
        }
    }

}
