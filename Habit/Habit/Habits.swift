//
//  Habits.swift
//  Habit
//
//  Created by Michael Wolf on 1/23/22.
//

import Foundation

class Habits: ObservableObject {
    @Published var habits: [Habit] {
        didSet {
             if let encoded = try? JSONEncoder().encode(habits) {
                 UserDefaults.standard.set(encoded, forKey: "Habits")
             }
         }
    }
    func increment(id: UUID) -> Void {
        let index = habits.firstIndex { $0.id == id }
        habits[index!].streakLength += 1
    }
    init () {
        if let savedItems = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
                habits = decodedItems
                return
            }
        }
        habits = []
    }
}
