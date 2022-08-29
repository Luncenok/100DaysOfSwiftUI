//
//  ContentView.swift
//  iExpense
//
//  Created by Mateusz Idziejczak on 24/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var indexOfFirstPersonal: Int? {
        expenses.items.firstIndex { item in
            item.type == "Personal"
        }
    }
    var indexOfFirstBusiness: Int? {
        expenses.items.firstIndex { item in
            item.type == "Business"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(expenses.items.enumerated()), id: \.element) { index, element in
                    if index == indexOfFirstPersonal {
                        Text("Personal expenses").font(.title)
                    }
                    if index == indexOfFirstBusiness {
                        Text("Business expenses").font(.title)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(element.name)
                            Text(element.type)
                        }
                        Spacer()
                        Text(element.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(element.amount < 10.0 ? .green : element.amount < 100.0 ? .orange : .red)
                    }
                }.onDelete(perform: removeItems)
            }
            .onAppear {
                expenses.items.sort { el1, el2 in
                    el1.type < el2.type
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
