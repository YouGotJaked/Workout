//
//  FavoritesViewController.swift
//  Workout
//
//  Created by Jake Day on 11/7/18.
//  Copyright © 2018 Jake Day. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
    // MARK: - Properties
    var workouts = Workout.load()
}

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = workout.category
        cell.detailTextLabel?.text = "\(workout.exercises.count) exercises"
        return cell
    }
}
