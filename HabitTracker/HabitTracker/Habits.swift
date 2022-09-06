//
//  Habits.swift
//  HabitTracker
//
//  Created by Mateusz Idziejczak on 06/09/2022.
//

import Foundation

class Habits: ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "habits") {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
                items = decoded
                return
            }
        }
        items = []
    }
}
