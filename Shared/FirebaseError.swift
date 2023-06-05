//
//  FirebaseError.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/4/23.
//

enum FirebaseError: Error {
    case noSnapshot
    case encodingError
    case namedError(String)
    case notFound
}
