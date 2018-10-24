//
//  WorkoutInterfaceController.swift
//  Watch Extension
//
//  Created by Jake Day on 10/16/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import WatchKit
import Foundation


class WorkoutInterfaceController: WKInterfaceController {
    @IBOutlet var categoryLabel: WKInterfaceLabel!
    @IBOutlet var exerciseNumberLabel: WKInterfaceLabel!
    @IBOutlet var exerciseLabel: WKInterfaceLabel!
    @IBOutlet var repetitionLabel: WKInterfaceLabel!
    @IBOutlet var intensityLabel: WKInterfaceLabel!
    @IBOutlet var favoriteButton: WKInterfaceButton!
    
    var workout: Workout? {
        didSet {
            guard let workout = workout else { return }
            
            categoryLabel.setText("\(workout.category)")
            exerciseNumberLabel.setText("Exercise 1") // change to current exercise in workout
            exerciseLabel.setText("\(workout.exercises[0])")
            repetitionLabel.setText("\(workout.exercises[0].sets) x \(workout.exercises[0].reps)")
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
            intensityLabel.setText("\(workout.intensity.rawValue)")
            
            // check if current exercise is favorite
            if workout.exercises[0].favorite {
                favoriteButton.setTitle("Y")
            } else {
                favoriteButton.setTitle("N")
            }
            // provide option to favorite and un-favorite, long press
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        workout = Workout.load()
    }
}
