//
//  GaugeProgressView.swift
//  ProgressView
//
//  Created by Kris Siangchaew on 16/10/2563 BE.
//

import SwiftUI

struct GaugeProgressView<T: ShapeStyle>: ProgressViewStyle {
    let trimAmount: Double
    let lineWidth: CGFloat
    let backgroundShapeStyle: T
    let foregroundShapeStyle: T
    let formatter = NumberFormatter()
    
    var rotation: Angle {
        Angle(radians: .pi/2 + .pi * (1 - trimAmount))
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0.0
        formatter.numberStyle = .percent
        
        let percent = formatter.string(from: fractionCompleted as NSNumber) ?? "0%"
        
        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(trimAmount))
                .stroke(backgroundShapeStyle, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(rotation)
            
            Circle()
                .trim(from: 0, to: CGFloat(trimAmount) * CGFloat(fractionCompleted))
                .stroke(foregroundShapeStyle, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(rotation)
            
            Text(percent)
                .fontWeight(.semibold)
                .animation(.none)
        }
    }
}
