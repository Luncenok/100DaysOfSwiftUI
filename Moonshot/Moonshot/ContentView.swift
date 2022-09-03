//
//  ContentView.swift
//  Moonshot
//
//  Created by Mateusz Idziejczak on 29/08/2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isGridView = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Some text is copied from Wikipedia \nCopyright © Wikipedia CC-BY-SA license")
                if isGridView {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(isGridView ? "List" : "Grid") {
                    isGridView.toggle()
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
