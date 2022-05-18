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

extension Person: Identifiable { }
extension Person: Codable { }
