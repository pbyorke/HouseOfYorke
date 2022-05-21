//
//  MainViewModel.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/17/22.
//

import Combine

class MainViewModel: ObservableObject {
    
    @Published var allFamilies: [Family] = []
    @Published var allPersons: [Person] = []
    @Published var family: Family? = nil
    @Published var person: Person? = nil
    
    var personsInAFamily: [Person] = []
    var childrenInAFamily: [Person] = []
    var areThereMultipleFamilies: Bool { allFamilies.count > 1 }
    var isSignedIn: Bool { person != nil }
    var needFamilySection: Bool { person != nil ? false : allFamilies.count > 1 && family == nil }
    var needPersonSection: Bool { person != nil ? false : family != nil }
    var password = ""
    var name: String { person?.name ?? "" }
    var points: Int { person?.points ?? 0 }
    var isAParent: Bool { person?.parent ?? false }

    private let familyDataService = FamilyDataService()
    private let personDataService = PersonDataService()
    private let dm = DefaultsManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getDefaults()
        addSubscribers()
    }
    
    func signon(family: Family) {
        self.family = family
        dm.setCurrentFamily(family)
    }
    
    func signon(person: Person) {
        self.person = person
        dm.setCurrentPerson(person)
    }
    
    func signoff() {
        if allFamilies.count == 1 {
            family = allFamilies[0]
        } else {
            family = nil
        }
        dm.setCurrentFamily(family)
        person = nil
        dm.setCurrentPerson(person)
    }

    private func getDefaults() {
        person = dm.getCurrentPerson()
        family = dm.getCurrentFamily()
    }
    
    private func addSubscribers() {
        
        // subscrption to get all families
        familyDataService
            .$allFamilies
            .sink { [weak self] families in
                self?.allFamilies = families
                if families.count == 1 {
                    self?.family = families[0]
                }
            }
            .store(in: &cancellables)
        
        // subscription to get all persons
        personDataService
            .$allPersons
            .combineLatest($allFamilies)
            .sink { [weak self] persons, families in
                self?.allPersons = persons
            }
            .store(in: &cancellables)
        
        // subscription to get all persons in selected family
        $family
            .combineLatest($allPersons)
            .map { chosenFamily, startingPersons -> [Person] in
                return startingPersons.filter { onePerson -> Bool in
                    return onePerson.familyID == chosenFamily?.id
                }
            }
            .sink { [weak self] chosenPersons in
                    self?.personsInAFamily = chosenPersons
            }
            .store(in: &cancellables)

        // subscription to get all children in selected family
        $family
            .combineLatest($allPersons)
            .map { chosenFamily, startingPersons -> [Person] in
                return startingPersons.filter { onePerson -> Bool in
                    return onePerson.familyID == chosenFamily?.id && !onePerson.parent
                }
            }
            .sink { [weak self] chosenPersons in
                    self?.childrenInAFamily = chosenPersons
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
