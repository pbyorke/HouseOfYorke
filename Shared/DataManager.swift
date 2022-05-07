//
//  DataManager.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/3/22.
//

import SwiftUI
import FirebaseFirestore

class DataManager: ObservableObject {
    
    static var shared = DataManager()
    
    private var familyListener: ListenerRegistration?
    private var personListener: ListenerRegistration?

    @AppStorage("currentPerson") private var currentPerson: Data = Data()
    @Published var families = [Family]()
    @Published var persons = [Person]()
    var children: [Person] { persons.filter { $0.parent == false } }
    
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
    
    var name: String { person?.name ?? "" }
    var points: Int { person?.points ?? 0 }
    var parent: Bool { person?.parent ?? false }

    var family: Family? {
        didSet {
            if let family = family {
                Task {
                    personListener = try await setupListener(collection: .persons, type: Person.self) { array in
                        self.persons = [Person]()
                        for item in array {
                            if item.familyID == family.id {
                                self.persons.append(item)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var person: Person? {
        didSet {
            Task {
                await save()
            }
        }
    }
    
    private init() {
        setup()
    }

    private func setup() {
        Task {
            do {
                familyListener = try await setupListener(collection: .families, type: Family.self) { array in
                    self.families = array
                }
            } catch { print("* * *  \(error.localizedDescription)") }
        }
    }

    private func setupListener<T: Codable>(collection: FirestoreType, type: T.Type, successful: @escaping ([T]) -> Void) async throws -> ListenerRegistration? {
        await person = getCurrentPerson()
        let listener = FirestoreType.reference(to: collection).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    do {
                        var objects = [T]()
                        for document in snapshot.documents {
                            let object = try document.decode(as: T.self, includingId: true)
                            objects.append(object)
                        }
                        successful(objects)
                    } catch { }
                }
            }
        }
        return listener
    }

    private func getCurrentPerson() async -> Person? {
        let person = try? JSONDecoder().decode(Person.self, from: currentPerson)
        return person
    }

    private func save() async {
        if let personData = try? JSONEncoder().encode(person) {
            DispatchQueue.main.async {
                self.currentPerson = personData
            }
        }
    }
    
    func signOff() {
        Task {
            person = nil
            family = nil
            await save()
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
