//
//  WorkoutRowController.swift
//  Watch Extension
//
//  Created by Jake Day on 10/23/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import WatchKit

class WorkoutRowController: NSObject {
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var categoryLabel: WKInterfaceLabel!
    @IBOutlet var intensityLabel: WKInterfaceLabel!
    @IBOutlet var exerciseNumberLabel: WKInterfaceLabel!
    
    var workout: Workout? {
        didSet {
            guard let workout = workout else { return }
            categoryLabel.setText(workout.category)
            // check workout intensity
            switch workout.intensity.rawValue {
            case "high":
                intensityLabel.setTextColor(.red)
            case "mix":
                intensityLabel.setTextColor(.cyan)
            case "low":
                intensityLabel.setTextColor(.green)
            default:
                intensityLabel.setAlpha(0) // make invisible
            }
            intensityLabel.setText(workout.intensity.rawValue.uppercased())
            exerciseNumberLabel.setText(
                "\(workout.exercises.count) EX")
        }
    }
    
    
}
