//
//  Workout.swift
//  Workout
//
//  Created by Jake Day on 10/16/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import WatchKit
import Foundation

// Custom data type to define intensity levels

enum Intensity: String, Codable {
    case low = "low"
    case mix = "mix"
    case high = "high"
}

extension Intensity: Equatable {
    static func == (lhs: Intensity, rhs: Intensity) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

class Workout: Codable, CustomStringConvertible {
    // PROPERTIES
    var category: String = "" {
        willSet(newCategory) {
            print("\(self.category) will be renamed as \(newCategory)")
        }
        didSet(oldCategory) {
            print("\(oldCategory) has been renamed to \(self.category)")
        }
    }
    var intensity: Intensity = Intensity.mix {
        willSet(newIntensity) {
            print("\(self.intensity) will be set to \(newIntensity)")
        }
        didSet(oldIntensity) {
            print("\(oldIntensity) has been renamed to \(self.intensity)")
        }
    }
    var exercises: [Exercise] = [] {
        willSet(newExercises) {
            print("\(self.exercises) will be set to \(newExercises)")
        }
        didSet(oldExercises) {
            print("\(oldExercises) has been modified to \(self.exercises)")
        }
    }
    // add dateCreated property
    
    var description: String {
        return """
        \nWORKOUT
        Category: \(self.category)
        Size: \(self.exercises.count)
        Intensity: \(self.intensity)
        Exercises: \(self.exercises)
        """
    }
    
    // CONSTRUCTOR
    init(category: String, intensity: Intensity = Intensity.mix, exercises: [Exercise] = []) {
        self.category = category
        self.intensity = intensity
        self.exercises = exercises
    }
    
    // MODIFICATION MEMBER FUNCTIONS
    func addExercise(e: Exercise) {
        exercises.append(e)
    }
    
    func insertExerciseAtFront(e: Exercise) {
        exercises.insert(e, at: 0)
    }
    
    func insertExerciseAtN(e: Exercise, n: Int) {
        exercises.insert(e, at: n)
    }
    
    func removeExercise(e: Exercise) {
        if let index = exercises.index(of: e) {
            exercises.remove(at: index)
        }
    }
    
    static func save<T: Encodable>(object: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // terminal viewing only
        guard let path = Bundle.main.path(forResource: "Workouts", ofType: "json") else { return }
        let data = try! encoder.encode(object)
        let jsonString = String(data: data, encoding: .utf8)!
        
        do {
            try jsonString.write(to: URL(fileURLWithPath: path), atomically: true, encoding: .utf8)
        } catch {
            print("FAILED WITH ERROR: \(error)") // implement actual catch
        }
    }
    
    static func load() -> [Workout] {
        do {
            guard let path = Bundle.main.path(forResource: "Workouts", ofType: "json") else { return [] }
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode([Workout].self, from: data)
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
            return jsonResult
        } catch {
            print("FAILED WITH ERROR: \(error)") // implement actual catch
            return [] // fix
        }
    }
}

extension Workout: Equatable {
    static func ==(lhs: Workout, rhs: Workout) -> Bool {
        return lhs.category == rhs.category &&
            lhs.intensity == rhs.intensity &&
            lhs.exercises == rhs.exercises
    }
}
