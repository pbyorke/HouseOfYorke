//
//  Encodable+Utils.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 4/29/22.
//

import SwiftUI

extension Encodable {
    
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String:Any] else { throw FirebaseError.encodingError }
        for key in keys {
            json[key] = nil
        }
        return json
    }
    
}
