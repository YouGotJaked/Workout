//
//  Exercise.swift
//  Workout
//
//  Created by Jake Day on 10/16/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

class Exercise {
    var name: String
    var primary: String
    var secondary: String?
    var sets: Int
    var reps: Int
    var index: Int?
    var favorite: Bool
    
    init(name: String, primary: String, secondary: String? = nil, sets: Int = 0, reps: Int = 0, index: Int? = nil, favorite: Bool = false) {
        self.name = name
        self.primary = primary
        self.secondary = secondary
        self.sets = sets
        self.reps = reps
        self.index = index
        self.favorite = favorite
    }

}

// Allow usage of == operator
extension Exercise: Equatable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name == rhs.name &&
            lhs.primary == rhs.primary &&
            lhs.secondary == rhs.secondary &&
            lhs.sets == rhs.sets &&
            lhs.reps == rhs.reps &&
            lhs.favorite == rhs.favorite
    }
}
