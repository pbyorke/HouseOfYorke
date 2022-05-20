//
//  PersonDataService.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/18/22.
//

import Combine
import FirebaseFirestore

class PersonDataService {
    
    @Published var allPersons: [Person] = []
    
    private var personSubscription: AnyCancellable?
    private var personListener: ListenerRegistration?

    init() {
        getPersons()
    }
    
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
                        self.allPersons = array
                    } catch { }
                }
            }
        }
    }

}
