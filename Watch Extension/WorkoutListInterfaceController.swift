//
//  WorkoutListInterfaceController.swift
//  Watch Extension
//
//  Created by Jake Day on 10/17/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import WatchKit
import Foundation


class WorkoutListInterfaceController: WKInterfaceController {
    @IBOutlet var workoutsTable: WKInterfaceTable!
    
    // property to hold all workout information as an array of Workout instances
    var workouts = Workout.load()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        workoutsTable.setNumberOfRows(workouts.size, withRowType: "WorkoutRow")
    }
}
