//
//  FirebaseError.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

enum FirebaseError: Error {
    case noSnapshot
    case encodingError
    case namedError(String)
    case notFound
}
