//
//  Person.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import Foundation

struct Person: Identifiable, Codable {
    
    var id          = ""
    var name        = ""
    var photoURL    = ""
    var familyID    = ""
    var admin       = false
    var parent      = false
    
}
