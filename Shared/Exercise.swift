//
//  Exercise.swift
//  Workout
//
//  Created by Jake Day on 10/16/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import Foundation

class Exercise: Codable, CustomStringConvertible {
    var name: String
    var primary: String
    var secondary: String?
    var sets: Int
    var reps: Int
    var favorite: Bool
    
    var description: String {
        return """
        \nEXERCISE
        Name: \(self.name)
        Primary: \(self.primary)
        Secondary: \(self.secondary ?? "")
        Sets: \(self.sets)
        Reps: \(self.reps)
        Favorite: \(self.favorite)
        """
    }
    
    init(name: String, primary: String, secondary: String = "", sets: Int = 0, reps: Int = 0, favorite: Bool = false) {
        self.name = name
        self.primary = primary
        self.secondary = secondary
        self.sets = sets
        self.reps = reps
        self.favorite = favorite
    }
    
    static func save<T: Encodable>(object: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // terminal viewing only
        guard let path = Bundle.main.path(forResource: "Exercises", ofType: "json") else { return }
        let data = try! encoder.encode(object)
        let jsonString = String(data: data, encoding: .utf8)!
        
        do {
            try jsonString.write(to: URL(fileURLWithPath: path), atomically: true, encoding: .utf8)
        } catch {
            print("FAILED WITH ERROR: \(error)") // implement actual catch
        }
    }
    
    static func load() -> [Exercise] {
        do {
            guard let path = Bundle.main.path(forResource: "Exercises", ofType: "json") else { return [] }
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode([Exercise].self, from: data)
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
            return jsonResult
        } catch {
            print("FAILED WITH ERROR: \(error)") // implement actual catch
        }
        return [Exercise(name: "DIDNT LOAD", primary: "WRONG", sets: 4,reps: 12, favorite: false)] // fix
    }
}

// Allow usage of == operator
extension Exercise: Equatable {
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name == rhs.name &&
            lhs.primary == rhs.primary &&
            lhs.secondary == rhs.secondary &&
            lhs.sets == rhs.sets &&
            lhs.reps == rhs.reps &&
            lhs.favorite == rhs.favorite
    }
}
