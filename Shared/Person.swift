//
//  Person.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import Foundation

struct Person {
    
    var id          = ""
    var name        = ""
    var photoURL    = ""
    var familyID    = ""
    var parent      = false
    var password    = ""
    var points      = 0
    
}

// MARK: - extension

extension Person {
    
    func dump() {
        print("* * *  P e r s o n")
        print("* * *  id       \"\(id)\"")
        print("* * *  name     \"\(name)\"")
        print("* * *  photoURL \"\(photoURL)\"")
        print("* * *  familyID \"\(familyID)\"")
        print("* * *  parent   \(parent ? "true" : "false")")
        print("* * *  password \"\(password)\"")
        print("* * *  points   \(points)")
    }
    
}

extension Person: Identifiable { }
extension Person: Codable { }
