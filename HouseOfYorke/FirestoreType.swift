//
//  FirestoreType.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/4/23.
//

import Foundation
import FirebaseFirestore

enum FirestoreType: String {
    
    case persons
        
    static func reference(to collection: FirestoreType) -> CollectionReference {
        return Firestore.firestore().collection(collection.rawValue)
    }

}

