//
//  MainViewModel.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/17/22.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    @Published var allFamilies: [Family] = []
    @Published var allPersons: [Person] = []
    @Published var family: Family? = nil
    @Published var person: Person? = nil
    
    var filteredPersons: [Person] = []
    var multipleFamilies: Bool { allFamilies.count > 1 }
    var isSignedIn: Bool { person != nil }
    var needFamily: Bool { person != nil ? false : allFamilies.count > 1 && family == nil }
    var needPerson: Bool { person != nil ? false : family != nil }
    var password = ""
    var name: String { person?.name ?? "" }
    var points: Int { person?.points ?? 0 }
    var children: [Person] { allPersons.filter { $0.parent == false } }
    var parent: Bool { person?.parent ?? false }
    let defaultsManager = DefaultsManager()

    private let familyDataService = FamilyDataService()
    private let personDataService = PersonDataService()
    private let dm = DefaultsManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getDefaults()
        addSubscribers()
    }
    
    func saveCurrentPerson(person: Person) {
        
    }
    
    func signon(family: Family) {
        self.family = family
        defaultsManager.setCurrentFamily(family)
    }
    
    func signon(person: Person) {
        self.person = person
        defaultsManager.setCurrentPerson(person)
    }
    
    func signoff() {
        if allFamilies.count == 1 {
            family = allFamilies[0]
        } else {
            family = nil
        }
        defaultsManager.setCurrentFamily(family)
        person = nil
        defaultsManager.setCurrentPerson(person)
    }

    private func getDefaults() {
        person = dm.getCurrentPerson()
        family = dm.getCurrentFamily()
    }
    
    private func addSubscribers() {
        
        familyDataService
            .$allFamilies
            .sink { [weak self] families in
                self?.allFamilies = families
                if families.count == 1 {
                    self?.family = families[0]
                }
            }
            .store(in: &cancellables)
        
        personDataService
            .$allPersons
            .combineLatest($allFamilies)
            .sink { [weak self] persons, families in
                self?.allPersons = persons
            }
            .store(in: &cancellables)
        
        $family
            .combineLatest($allPersons)
            .map { chosenFamily, startingPersons -> [Person] in
                return startingPersons.filter { onePerson -> Bool in
                    return onePerson.familyID == chosenFamily?.id
                }
            }
            .sink { [weak self] chosenPersons in
                self?.filteredPersons = chosenPersons
            }
            .store(in: &cancellables)

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
        } catch { print("\(error.localizedDescription)") }
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
