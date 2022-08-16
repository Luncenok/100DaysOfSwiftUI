//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Mateusz Idziejczak on 15/08/2022.
//

import SwiftUI

struct prominentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func asProminentTitle() -> some View {
        modifier(prominentTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .asProminentTitle()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
