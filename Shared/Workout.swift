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

class Workout: Codable {
    // PROPERTIES
    var category: String = "" {
        willSet(newCategory) {
            print("\(self.category) will be renamed as \(newCategory)")
        }
        didSet(oldCategory) {
            print("\(oldCategory) has been renamed to \(self.category)")
        }
    }
    var size: Int = 0 {
        willSet(newSize) {
            print("\(self.size) will be set to \(newSize)")
        }
        didSet(oldSize) {
            print("\(oldSize) has been resized to \(self.size)")
        }
    }
    var intensity: Intensity = Intensity.mix {
        willSet(newIntensity) {
            print("\(self.intensity) will be set to \(newIntensity)")
        }
        didSet(oldIntensity) {
            print("\(oldIntensity) has been renamed to \(self.size)")
        }
    }
    // add dateCreated property
    var exercises: [Exercise] = []
    
    // CONSTRUCTOR
    init(category: String, size: Int = 6, intensity: Intensity = Intensity.mix) {
        self.category = category
        self.size = size
        self.intensity = intensity
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
    
    // fix implementation
    class func allWorkouts() -> [Workout] {
        var workouts: [Workout] = []
        guard let path = Bundle.main.path(forResource: "Workouts", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return workouts
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
            //json.forEach({ (dict: [String: String]) in workouts.append(Workout(dictionary: dict, formatter: formatter)) })
        } catch {
            print(error) // better error handling
        }
        return workouts
    }
    
    static let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    static let fileURL = DocumentDirURL.appendingPathComponent("/iOS/Workout/Shared/Workouts").appendingPathExtension("json")
    
    static func save<T: Encodable>(object: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // terminal viewing only
        let data = try! encoder.encode(object)
        let jsonString = String(data: data, encoding: .utf8)!
        
        do {
            try jsonString.write(to: Workout.fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("FAILED WITH ERROR: \(error)") // implement actual catch
        }
    }
    
    static func load() -> Workout {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Exercise.fileURL.path), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode(Workout.self, from: data)
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
            return jsonResult
        } catch {
            print("FAILED WITH ERROR: \(error)") // implement actual catch
            return Workout(category: "legs", size: 2, intensity: Intensity.low) // fix
        }
    }
    /*
    convenience init(dictionary: [String: String]) {
        <#statements#>
    }
    */
}

extension Workout: Equatable {
    static func ==(lhs: Workout, rhs: Workout) -> Bool {
        return lhs.category == rhs.category &&
            lhs.size == rhs.size &&
            lhs.intensity == rhs.intensity &&
            lhs.exercises == rhs.exercises
    }
}
