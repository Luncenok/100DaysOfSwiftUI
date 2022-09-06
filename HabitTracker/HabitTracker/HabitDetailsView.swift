//
//  HabitDetailsView.swift
//  HabitTracker
//
//  Created by Mateusz Idziejczak on 06/09/2022.
//

import SwiftUI

struct HabitDetailsView: View {
    @ObservedObject var habits: Habits
    @State var habit: Habit
    
    var body: some View {
        VStack {
            Spacer()
            Text(habit.name)
                .font(.title.bold())
            Text(habit.description)
                .font(.headline)
            Spacer()
            Text("Completed \(habit.completedAmount) times")
            Button {
                let index = habits.items.firstIndex(of: habit)
                var activity = habit
                activity.completedAmount += 1
                habits.items[index!] = activity
                habit = activity
            } label: {
                Image(systemName: "plus")
            }.padding()
            Spacer()
            Spacer()
        }
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailsView(habits: Habits(), habit: Habit(name: "test", description: "test description"))
    }
}
