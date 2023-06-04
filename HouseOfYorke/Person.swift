//
//  Person.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/3/23.
//

import Foundation

struct Person {
    
    let id:         String
    let name:       String
    let password:   String
    let points:     Int
    let parent:     Bool
    
}

// MARK: - Identifiable

extension Person: Identifiable { }

// MARK: - Codable

extension Person: Codable { }

