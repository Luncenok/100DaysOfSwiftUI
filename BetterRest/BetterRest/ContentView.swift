//
//  ContentView.swift
//  BetterRest
//
//  Created by Mateusz Idziejczak on 16/08/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 2
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var messagee: Binding<String> { Binding(
        get: {
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hour = (components.hour ?? 0)*3600
                let minutes = (components.minute ?? 0)*60
                let seconds = Double(hour+minutes)
                
                let prediction = try model.prediction(wake: seconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep
                return "Your ideal bedtime is "+sleepTime.formatted(date: .omitted, time: .shortened)
            } catch {
                alertTitle = "Error! "
                alertMessage = "There was a problem. Sorry"
                showingAlert = true
                return alertTitle+alertMessage
            }
        },
        set: { _ in
            
        }
    )}
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section("Daily coffee intake") {
                    Picker("Nubmer of cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0) \($0 == 1 ? "cup" : "cups")")
                        }
                    }
                }
                Section {
                Text(messagee.wrappedValue)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
