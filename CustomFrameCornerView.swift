//
//  CustomFrameCornerView.swift
//  SwiftUILab1
//
//  Created by Kris Siangchaew on 10/10/2563 BE.
//

import SwiftUI

struct CustomFrameCornerView: View {
    var color: Color = .blue
    var tr: CGFloat = 0.0
    var br: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var tl: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let w = geo.size.width
                let h = geo.size.height
                
                let tr = min(min(self.tr, w/2), h/2)
                let br = min(min(self.br, w/2), h/2)
                let tl = min(min(self.tl, w/2), h/2)
                let bl = min(min(self.bl, w/2), h/2)
                
                path.move(to: CGPoint(x: w/2, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(
                    center: CGPoint(x: w - tr, y: tr),
                    radius: tr,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h-br))
                path.addArc(
                    center: CGPoint(x: w - br, y: h-br),
                    radius: br,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
                path.addLine(to: CGPoint(x: 0-bl, y: h))
                path.addArc(
                    center: CGPoint(x: bl, y: h-bl),
                    radius: bl,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(
                    center: CGPoint(x: tl, y: tl),
                    radius: tl,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
                path.addLine(to: CGPoint(x: w/2, y: 0))
            }
            .fill(self.color)
        }
    }
}
