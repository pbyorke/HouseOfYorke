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
    var admin       = false
    var parent      = false
    
}

// MARK: - extension

extension Person {
    
    func dump() {
        print("* * *  P e r s o n")
        print("* * *  id       \"\(id)\"")
        print("* * *  name     \"\(name)\"")
        print("* * *  photoURL \"\(photoURL)\"")
        print("* * *  familyID \"\(familyID)\"")
        print("* * *  admin    \(admin ? "true" : "false")")
        print("* * *  parent   \(parent ? "true" : "false")")
    }
    
}

extension Person: Identifiable { }
extension Person: Codable { }
