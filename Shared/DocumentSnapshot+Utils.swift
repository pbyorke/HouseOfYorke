//
//  DocumentSnapshot+Utils.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import FirebaseFirestore

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        guard var documentJson = data() else { throw  FirebaseError.encodingError }
        if includingId {
            documentJson["id"] = documentID
        }
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        return decodedObject
    }
    
}
