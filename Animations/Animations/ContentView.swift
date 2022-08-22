//
//  ContentView.swift
//  Animations
//
//  Created by Mateusz Idziejczak on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    var body: some View {
        VStack {
            //            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            //            Spacer()
            Button("Tap me") {
                withAnimation {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0.3, z: 0))
            //            .overlay(
            //                Circle()
            //                    .stroke(.red)
            //                    .scaleEffect(animationAmount)
            //                    .opacity(2-animationAmount)
            //                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
            //            )
            //            .scaleEffect(animationAmount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
