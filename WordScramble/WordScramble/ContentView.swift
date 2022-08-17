//
//  ContentView.swift
//  WordScramble
//
//  Created by Mateusz Idziejczak on 17/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Text("Hello, world! 0")
                .padding()
            Text("Hello, world! 1")
                .padding()
            ForEach(2..<6) {
                Text("Hello, world! \($0)")
                    .padding()
            }
        }
    }
    
    func loadFile() {
        if let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileUrl) {
                let words = fileContents.components(separatedBy: "\n")
                let randomWord = words.randomElement() ?? ""
                let trimmed = randomWord.trimmingCharacters(in: .whitespacesAndNewlines)
                let checker = UITextChecker()
                let range = NSRange(location: 0, length: trimmed.utf16.count)
                let misspelledRange = checker.rangeOfMisspelledWord(in: trimmed, range: range, startingAt: 0, wrap: false, language: "en")
                let allGood = misspelledRange.location == NSNotFound
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
