//
//  FamilyDataService.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/18/22.
//

import Combine
import FirebaseFirestore

class FamilyDataService {
    
    @Published var allFamilies: [Family] = []
    
    private var familySubscription: AnyCancellable?
    private var familyListener: ListenerRegistration?

    init() {
        getFamilies()
    }
    
    private func getFamilies() {
        familyListener = FirestoreType.reference(to: .families).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    do {
                        var array: [Family] = []
                        for document in snapshot.documents {
                            let entry = try document.decode(as: Family.self, includingId: true)
                            array.append(entry)
                        }
                        self.allFamilies = array
                    } catch { }
                }
            }
        }
    }

}
