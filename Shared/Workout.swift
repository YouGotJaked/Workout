//
//  Workout.swift
//  Workout
//
//  Created by Jake Day on 10/16/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import WatchKit

class Workout {
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
    var intensity: Bool = false {
        willSet(newIntensity) {
            print("\(self.intensity) will be set to \(newIntensity)")
        }
        didSet(oldIntensity) {
            print("\(oldIntensity) has been renamed to \(self.size)")
        }
    }
    var exercises: [Exercise] = []
    
    // CONSTRUCTOR
    init(category: String, size: Int = 6, intensity: Bool = true) {
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
    
    class func allExercises() -> [Exercise] {
        var exercises: [Exercise] = []
        guard let path = Bundle.main.path(forResource: ")
    }
    
    class func allFlights() -> [Flight] {
        var flights: [Flight] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let path = Bundle.main.path(forResource: "Flights", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return flights
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
            json.forEach({ (dict: [String: String]) in flights.append(Flight(dictionary: dict, formatter: formatter)) })
        } catch {
            print(error)
        }
        
        return flights
    }
    
    /*
    convenience init(dictionary: [String: String]) {
        <#statements#>
    }
    */
}
