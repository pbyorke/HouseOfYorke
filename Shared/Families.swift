//
//  Families.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import Foundation
import FirebaseFirestore

class Families: ObservableObject {

    static let shared = Families()
    @Published var persons = [Person]()
    private var personListener: ListenerRegistration?
    
    private init() {
        listenAllPersons()
    }
    
    private func listenAllPersons() {
        personListener = Firestore.firestore().collection("persons").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            do {
                var objects = [Person]()
                for document in snapshot.documents {
                    let object = try document.decode(as: Person.self, includingId: true)
                    objects.append(object)
                }
                DispatchQueue.main.async { [self] in
                    persons = objects
                }
            } catch {
                print("* * *  listenAllPersons error \"\(error.localizedDescription)\"")
            }
        }
    }
        
}
