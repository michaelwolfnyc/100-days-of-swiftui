//
//  Habit.swift
//  Habit
//
//  Created by Michael Wolf on 1/23/22.
//

import Foundation

struct Habit: Identifiable, Codable {
    var name: String
    var streakLength: Int = 0
    var id = UUID()
}
