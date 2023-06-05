//
//  PersonDataManager.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/4/23.
//

import FirebaseFirestore

class PersonDataManager {
    
    static var shared = PersonDataManager()
    
    @Published var persons: [Person] = []
    
    private var personListener: ListenerRegistration?

    init() { getPersons() }
    
    private func getPersons() {
        personListener = FirestoreType.reference(to: .persons).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    do {
                        var array: [Person] = []
                        for document in snapshot.documents {
                            let entry = try document.decode(as: Person.self, includingId: true)
                            array.append(entry)
                        }
                        self.persons = array
                    } catch { }
                }
            }
        }
    }
    
//    func adjust(_ child: Person?, _ amount: Int) {
//        if let child = child {
//            var adjustedAmount = amount
//            if adjustedAmount != 0 {
//                adjustedAmount = child.points + amount
//            }
//            let newPerson = Person (
//                id: child.id,
//                name: child.name,
//                familyID: child.familyID,
//                points: adjustedAmount,
//                parent: child.parent,
//                password: child.password,
//                comments: child.password,
//                photoURL: child.photoURL
//            )
//            do {
//                try update(newPerson, collection: .persons)
//            } catch { print("\(error.localizedDescription)") }
//        }
//    }

    func update<T: Encodable & Identifiable>(_ object: T, collection: FirestoreType) throws {
        do {
            let json = try object.toJson(excluding: ["id"])
            let id = "\(object.id)"
            FirestoreType.reference(to: collection).document(id).setData(json)
        } catch {
            throw FirebaseError.namedError(error.localizedDescription)
        }
    }

}
