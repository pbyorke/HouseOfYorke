//
//  DataManager.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/3/22.
//

import Foundation
import FirebaseFirestore

class DataManager: ObservableObject {
    
    static var shared = DataManager()
    
    private var familyListener: ListenerRegistration?
    private var personListener: ListenerRegistration?

    var family: Family?
    var person: Person?
    
    @Published var families = [Family]()
    @Published var persons = [Person]()
    
    var multipleFamilies: Bool { families.count > 1 }
    var oneFamily: Bool { families.count == 1 }

    var familyFilter: Family? {
        didSet {
            if let _ = familyFilter {
                Task {
                    personListener = try await setupListener(collection: .persons, type: Person.self) { array in
                        self.persons = array
                    }
                }
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
                personListener = try await setupListener(collection: .persons, type: Person.self) { array in
                    self.persons = array
                }
            } catch {
            }
        }
    }

    private func setupListener<T: Codable>(collection: FirestoreType, type: T.Type, successful: @escaping ([T]) -> Void) async throws -> ListenerRegistration? {
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
                    } catch {
                    }
                }
            }
        }
        return listener
    }

}
