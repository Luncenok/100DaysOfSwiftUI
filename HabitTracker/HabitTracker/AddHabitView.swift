//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Mateusz Idziejczak on 06/09/2022.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        Form {
            Section("Habit name") {
                TextField("Name", text: $name)
            }
            Section("Habit description") {
                TextField("Description", text: $description)
            }
        }
        .navigationTitle("Add habit")
        .toolbar {
            Button("Save") {
                let habit = Habit(name: name, description: description)
                habits.items.append(habit)
                dismiss()
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
