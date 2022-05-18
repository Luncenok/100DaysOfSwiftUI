//
//  ContentView.swift
//  WeSplit
//
//  Created by Mateusz Idziejczak on 18/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Hello \(name)")
                    Button("Tap Count: \(tapCount)") {
                        tapCount += 1
                    }
                    ForEach(0..<100) {
                        Text("Row: \($0)")
                    }
                }
                Section {
                    Picker("Select student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) {
                            Text($0)
                        }
                    }
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
