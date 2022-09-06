//
//  ContentView.swift
//  HabitTracker
//
//  Created by Mateusz Idziejczak on 06/09/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    NavigationLink {
                        HabitDetailsView(habits: habits, habit: habit)
                    } label: {
                        Text(habit.name)
                    }
                }
            }
            .navigationTitle("Habit tracker")
            .toolbar {
                NavigationLink {
                    AddHabitView(habits: habits)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
