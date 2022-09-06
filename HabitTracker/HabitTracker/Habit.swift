//
//  Habit.swift
//  HabitTracker
//
//  Created by Mateusz Idziejczak on 06/09/2022.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var completedAmount = 0
}
