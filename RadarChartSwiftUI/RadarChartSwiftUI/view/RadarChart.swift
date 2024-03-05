//
//  RadarChart.swift
//  RadarChartSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 03/03/24.
//

import SwiftUI

struct RadarChart: View {
    let data: [Double]
    let labels: [String]
    let maxValues: [Double]
    let designInterval: Double
    let shapeColor: Color
    let frameHeight: CGFloat?
    let frameWidth: CGFloat?
    
    init(data: [Double], labels: [String], maxValues: [Double], designInterval: Double, shapeColor: Color, frameHeight: CGFloat? = nil, frameWidth: CGFloat? = nil) {
        self.data = data
        self.labels = labels
        self.maxValues = maxValues
        self.designInterval = designInterval
        self.shapeColor = shapeColor
        self.frameHeight = frameHeight
        self.frameWidth = frameWidth
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RadarChartShape(data: data, maxValues: maxValues, frameSize: geometry.size, shapeColor: shapeColor)
                RadarChartLabels(labels: labels, frameSize: geometry.size)
            }
        }
        .frame(width: frameWidth, height: frameHeight)
    }
}

struct RadarChartShape: View {
    let data: [Double]
    let maxValues: [Double]
    let frameSize: CGSize
    let shapeColor: Color
    
    var body: some View {
        ZStack {
            Path { path in
                           let radius = min(frameSize.width, frameSize.height) / 2
                           let center = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
                           let angle = 2 * .pi / Double(data.count)
                           
                           for i in 0..<data.count {
                               let currentAngle = Double(i) * angle - .pi / 2
                               let x = center.x + CGFloat(radius * cos(currentAngle))
                               let y = center.y + CGFloat(radius * sin(currentAngle))
                               
                               if i == 0 {
                                   path.move(to: CGPoint(x: x, y: y))
                               } else {
                                   path.addLine(to: CGPoint(x: x, y: y))
                               }
                           }
                           path.closeSubpath()
                       }
                       .stroke(Color.white.opacity(0.5), lineWidth: 2)
            
            
            
            // Lines from vertices to center
                       let radius = min(frameSize.width, frameSize.height) / 2
                       let center = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
                       let angle = 2 * .pi / Double(data.count)
                       ForEach(0..<data.count, id: \.self) { i in
                           let currentAngle = Double(i) * angle - .pi / 2
                           let x = center.x + CGFloat(radius * cos(currentAngle))
                           let y = center.y + CGFloat(radius * sin(currentAngle))
                           
                           Path { path in
                               path.move(to: center)
                               path.addLine(to: CGPoint(x: x, y: y))
                           }
                           .stroke(Color.white.opacity(0.5), lineWidth: 1)
                       }
            
            
            ForEach(0..<data.count, id: \.self) { index in
                let radius = min(frameSize.width, frameSize.height) / 2
                let center = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
                let angle = 2 * .pi / Double(data.count)
                
                let currentAngle = Double(index) * angle - .pi / 2
                let currentRadius = (data[index] / maxValues[index]) * radius
                let x = center.x + CGFloat(currentRadius * cos(currentAngle))
                let y = center.y + CGFloat(currentRadius * sin(currentAngle))
                
                Circle()
                    .fill(shapeColor)
                    .frame(width: 10, height: 10)
                    .position(x: x, y: y)
            }
            
            Path { path in
                let radius = min(frameSize.width, frameSize.height) / 2
                let center = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
                let angle = 2 * .pi / Double(data.count)
                
                for i in 0..<data.count {
                    let currentAngle = Double(i) * angle - .pi / 2
                    let currentRadius = (data[i] / maxValues[i]) * radius
                    let x = center.x + CGFloat(currentRadius * cos(currentAngle))
                    let y = center.y + CGFloat(currentRadius * sin(currentAngle))
                    
                    if i == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                path.closeSubpath()
            }
            .fill(shapeColor.opacity(0.3))
            .stroke(shapeColor.opacity(0.5), lineWidth: 1)
        }
    }
}

struct RadarChartLabels: View {
    let labels: [String]
    let frameSize: CGSize
    
    var body: some View {
        let radius = min(frameSize.width, frameSize.height) / 2
        let angle = 2 * .pi / Double(labels.count)
        
        ForEach(0..<labels.count, id: \.self) { index in
            let currentAngle = Double(index) * angle - .pi / 2
            let x = frameSize.width / 2 + (radius + 20) * CGFloat(cos(currentAngle))
            let y = frameSize.height / 2 + (radius + 20) * CGFloat(sin(currentAngle))
            
            Text(labels[index])
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .position(x: x, y: y)
        }
    }
}
