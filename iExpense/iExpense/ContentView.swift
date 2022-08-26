//
//  ContentView.swift
//  iExpense
//
//  Created by Mateusz Idziejczak on 24/08/2022.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Ekl"
}

struct User2: Codable {
    let firstname: String
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @StateObject var user = User()
    @State private var showingSheet = false
    @State private var currentNumber = 1
    @AppStorage("tapCount") private var tapCount = 0
    @State private var numbers = [Int]()
    @State private var user2 = User2(firstname: "Taylor")
    var body: some View {
        NavigationView {
            VStack {
                Button("Tap count: \(tapCount)") {
                    tapCount += 1
                }
                Button("Save user2") {
                    let encoder = JSONEncoder()
                    if let data = try? encoder.encode(user2) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                Button("Show Sheet") {
                    showingSheet.toggle()
                }.sheet(isPresented: $showingSheet) {
                    SecondView(name: "Mati")
                }
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row: \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.navigationTitle("onDelete()")
                .toolbar {
                    EditButton()
                }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
