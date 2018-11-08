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
    @IBOutlet var exerciseIndexLabel: WKInterfaceLabel!
    @IBOutlet var exerciseLabel: WKInterfaceLabel!
    @IBOutlet var repetitionLabel: WKInterfaceLabel!
    @IBOutlet var intensityLabel: WKInterfaceLabel!
    @IBOutlet var favoriteButton: WKInterfaceButton!
    
    var exerciseIndex = 0
    
    var workout: Workout? {
        didSet {
            guard let workout = workout else { return }
            
            categoryLabel.setText("\(workout.category)")
            exerciseIndexLabel.setText("Exercise \(exerciseIndex + 1)") // change to current exercise in workout
            exerciseLabel.setText("\(workout.exercises[exerciseIndex].name)")
            repetitionLabel.setText("\(workout.exercises[exerciseIndex].sets) x \(workout.exercises[exerciseIndex].reps)")
            
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
            intensityLabel.setText("\(workout.intensity.rawValue.uppercased())")
            
            // check if current exercise is favorite
            workout.exercises[exerciseIndex].favorite ? favoriteButton.setTitle("💔") : favoriteButton.setTitle("❤️")
            
            // provide option to favorite and un-favorite, long press
        }
    }
    
    private func setExercise() {
        exerciseIndexLabel.setText("Exercise \(exerciseIndex + 1)") // change to current exercise in workout
        exerciseLabel.setText("\(self.workout?.exercises[exerciseIndex].name ?? "nil")")
        repetitionLabel.setText("\(self.workout?.exercises[exerciseIndex].sets ?? -1) x \(self.workout?.exercises[exerciseIndex].reps ?? -1)")
        // check if current exercise is favorite
        (self.workout?.exercises[exerciseIndex].favorite)! ? favoriteButton.setTitle("💔") : favoriteButton.setTitle("❤️")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let workout = context as? Workout {
            self.workout = workout
        }
    }

    // Press favorite button (double tap or long press later?) to add/remove from favorites
    @IBAction func favoritButtonPress() {
        guard let favorite = self.workout?.exercises[exerciseIndex].favorite else { return }
        
        favorite ? favoriteButton.setTitle("💔") : favoriteButton.setTitle("❤️")

        self.workout?.exercises[exerciseIndex].favorite = !favorite
    }
    
    // Swipe left to navigate to next exercise in workout
    @IBAction func swipeLeft(gesture: WKGestureRecognizer) {
        // prevent scrolling past last index
        if exerciseIndex >= (self.workout?.exercises.count)! - 1 { return }
        
        if let swipeGesture = gesture as? WKSwipeGestureRecognizer {
            if swipeGesture.direction == WKSwipeGestureRecognizerDirection.left {
                    exerciseIndex += 1
                    print("Swipe left")
                    print("exerciseIndex = \(exerciseIndex)")
                    setExercise()
            }
        }
    }
    
    // Swipe right to navigate to previous exercise in workout
    @IBAction func swipeRight(gesture: WKGestureRecognizer) {
        // prevent scrolling past first index
        if exerciseIndex <= 0 { return }
        
        if let swipeGesture = gesture as? WKSwipeGestureRecognizer {
            if swipeGesture.direction == WKSwipeGestureRecognizerDirection.right {
                exerciseIndex -= 1
                print("Swipe right")
                print("exerciseIndex = \(exerciseIndex)")
                setExercise()
            }
        }
    }
    
    // Swipe down to return to WorkoutListInterface
    @IBAction func swipeDown(gesture: WKGestureRecognizer) {
        if let swipeGesture = gesture as? WKSwipeGestureRecognizer {
            if swipeGesture.direction == WKSwipeGestureRecognizerDirection.down {
                print("Swipe down")
                presentController(withName: "WorkoutList", context: workout)
            }
        }
    }
}

