//
//  DefaultsManager.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/13/22.
//

import SwiftUI

class DefaultsManager {
    
    let defaults = UserDefaults.standard
    let familyKey = "currentFamily"
    let personKey = "currentPerson"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    func reset() {
        defaults.removeObject(forKey: familyKey)
        defaults.removeObject(forKey: personKey)
    }
    
    func getCurrentFamily() -> Family? {
        let data = defaults.data(forKey: familyKey)
        if data == nil {
            return nil
        } else {
            do {
                let family = try decoder.decode(Family.self, from: data!)
                return family
            } catch {
                return nil
            }
        }
    }
    
    func getCurrentPerson() -> Person? {
        let data = defaults.data(forKey: personKey)
        if data == nil {
            return nil
        } else {
            do {
                let person = try decoder.decode(Person.self, from: data!)
                return person
            } catch {
                return nil
            }
        }
    }
    
    func setCurrentFamily(_ family: Family?) {
        if family == nil {
            defaults.removeObject(forKey: familyKey)
        } else {
            do {
                let data = try encoder.encode(family)
                defaults.set(data, forKey: familyKey)
            } catch { }
        }
    }
    
    func setCurrentPerson(_ person: Person?) {
        if person == nil {
            defaults.removeObject(forKey: personKey)
        } else {
            do {
                let data = try encoder.encode(person)
                defaults.set(data, forKey: personKey)
            } catch { }
        }
    }
    
}
