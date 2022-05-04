//
//  FirestoreType.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import Foundation
import FirebaseFirestore

enum FirestoreType: String {
    case families
    case persons
        
    static func reference(to collection: FirestoreType) -> CollectionReference {
        return Firestore.firestore().collection(collection.rawValue)
    }

}

