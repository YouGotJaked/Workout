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
            exerciseNumberLabel.setText("Exercise \(workout.exercises[].index)")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        workout = Workout.allWorkouts().first
    }
}
