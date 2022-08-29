//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Mateusz Idziejczak on 29/08/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
