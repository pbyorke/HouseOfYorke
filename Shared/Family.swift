//
//  Family.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import Foundation

struct Family {
    
    var id = ""
    var name = ""
    
}

// MARK: - extension

extension Family {
    
    func dump() {
        print("* * *  F a m i l y")
        print("* * *  id   \"\(id)\"")
        print("* * *  name \"\(name)\"")
    }
    
}

extension Family: Identifiable { }
extension Family: Codable { }
