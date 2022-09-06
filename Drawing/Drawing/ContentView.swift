//
//  ContentView.swift
//  Drawing
//
//  Created by Mateusz Idziejczak on 03/09/2022.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) {value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY - insetAmount))
        path.addLine(to: CGPoint(x: rect.minX + insetAmount*2, y: rect.midY + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX - 20.0 + insetAmount, y: rect.midY + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX - 20.0 + insetAmount, y: rect.minY + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX + 20.0 - insetAmount, y: rect.minY + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX + 20.0 - insetAmount, y: rect.midY + insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount*2, y: rect.midY + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - insetAmount))
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount = amount
        return arrow
    }
}

struct ColorCyclingArrow: View {
    var amount = 0.0
    var steps = 20
    var body: some View {
        ZStack {
            ForEach(0..<steps) {num in
                Arrow()
                    .inset(by: Double(num))
                    .stroke(color(for: num), lineWidth: 2)
            }
        }
    }
    
    func color(for value: Int) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: 1)
        
    }
}

struct ContentView: View {
    @State private var petalOffset = -50.0
    @State private var petalWidth = 50.0
    @State private var scale = 0.2
    @State private var colorCycle = 0.0
    @State private var amount = 0.7
    @State private var insetAmount = 50.0
    @State private var rows = 4
    @State private var columns = 4
    @State private var lineWidth = 20.0
    @State private var arrowCycle = 20.0
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    ColorCyclingArrow(amount: arrowCycle)
                        .frame(width: 200, height: 200)
                    Slider(value: $arrowCycle)
                    Arrow()
                        .stroke(.mint, lineWidth: lineWidth)
                        .frame(width: 200, height: 200)
                        .padding(30)
                        .onTapGesture {
                            withAnimation {
                                lineWidth = Double.random(in: 2.0...30.0)
                            }
                        }
                    Checkerboard(rows: rows, columns: columns)
                        .fill(.cyan)
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            withAnimation(.linear(duration: 3)) {
                                rows = 8
                                columns = 16
                            }
                        }
                    Trapezoid(insetAmount: insetAmount)
                        .fill(.yellow)
                        .frame(width: 200, height: 100)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                insetAmount = Double.random(in: 10...90)
                            }
                        }
                }
                ZStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 200 * amount)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)
                    Circle()
                        .fill(.green)
                        .frame(width: 200 * amount)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)
                    Circle()
                        .fill(.blue)
                        .frame(width: 200 * amount)
                        .blendMode(.screen)
                }
                .frame(width: 300, height: 300)
                Slider(value: $amount)
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 300, height: 300)
                Slider(value: $colorCycle)
                ZStack {
                    Path {path in
                        path.move(to: CGPoint(x: 200, y: 100))
                        path.addLine(to: CGPoint(x: 100, y: 300))
                        path.addLine(to: CGPoint(x: 300, y: 300))
                        path.addLine(to: CGPoint(x: 200, y: 100))
                    }
                    .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    
                    Triangle()
                        .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .frame(width: 300, height: 300)
                    
                    Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                        .stroke(.blue, lineWidth: 10)
                    //.strokeBorder(.blue, lineWidth: 10)
                        .frame(width: 300, height: 300)
                    
                    Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                        .stroke(.red, lineWidth: 1)
                    //.fill(.red, style: FillStyle(eoFill: true))
                }
                Slider(value: $petalWidth, in: -40...40)
                Slider(value: $petalOffset, in: -100...100)
                Text("Hello")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("armstrong"), scale: scale), width: 50)
                Slider(value: $scale, in: 0.0...1.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
