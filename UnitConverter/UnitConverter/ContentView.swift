//
//  ContentView.swift
//  UnitConverter
//
//  Created by Mateusz Idziejczak on 18/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUnit1 = "sec"
    @State private var selectedUnit2 = "sec"
    @State private var amount = 0.0
    
    let units1 = ["sec": 1.0, "min": 60.0, "hour": 3600.0, "day": 86400.0]
    var units2: [String: Double] {
        var unitsCopy = units1
        unitsCopy.removeValue(forKey: selectedUnit1)
        return unitsCopy
    }
    
    var converted: Double {
        return amount*(units1[selectedUnit1] ?? 1.0)/(units2[selectedUnit2] ?? 1.0)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .number)
                }
                Section {
                    Picker("Choose Fisrt Unit", selection: $selectedUnit1) {
                        ForEach(units1.map {$0.key}, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                    Picker("Choose Second Unit", selection: $selectedUnit2) {
                        ForEach(units2.map {$0.key}, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("CHOOSE UNITS")
                }
                Section {
                    Text("\(amount.formatted()) \(selectedUnit1) = \(converted.formatted()) \(selectedUnit2)")
                } header: {
                    Text("result")
                }
            }.navigationTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
