//
//  TopFixedShape.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/24.
//

import SwiftUI

extension ToolTipShape {
    
    func fixedTopPath(in rect: CGRect) -> Path {
        Path { path in
            let centerPoint = calFixedCenterPointToTop(in: rect)
            
            path.move(to: CGPoint(x: centerPoint.x - (model.tailSize.width / 2),
                                  y: centerPoint.y))
                        
            path.addLine(to: CGPoint(x: centerPoint.x ,
                                     y: centerPoint.y - model.tailSize.height))
            
            path.addLine(to: CGPoint(x: centerPoint.x + (model.tailSize.width / 2),
                                     y: centerPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX - model.cornerRadius,
                                     y: centerPoint.y))
            
            path.addArc(center: CGPoint(x: rect.maxX - model.cornerRadius,
                                        y: rect.minY + model.cornerRadius),
                        radius: model.cornerRadius - insetValue,
                        startAngle: .degrees(270),
                        endAngle: .degrees(0),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.maxY - model.cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.maxX - model.cornerRadius,
                                        y: rect.maxY - model.cornerRadius),
                        radius: model.cornerRadius - insetValue,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minY + model.cornerRadius,
                                     y: rect.maxY - insetValue))
            
            path.addArc(center: CGPoint(x: rect.minY + model.cornerRadius,
                                        y: rect.maxY - model.cornerRadius),
                        radius: model.cornerRadius - insetValue,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minY + insetValue,
                                     y: rect.minY + model.cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.minX + model.cornerRadius,
                                        y: rect.minY + model.cornerRadius),
                        radius: model.cornerRadius - insetValue,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
            
            path.closeSubpath()
        }
    }
}
