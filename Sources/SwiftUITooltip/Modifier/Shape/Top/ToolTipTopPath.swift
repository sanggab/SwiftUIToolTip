//
//  ToolTipTopPath.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

struct ToolTipTopPath: PathFeatures {
    @ObservedObject var viewModel: ToolTipViewModel
    private var insetValue: CGFloat
    
    init(viewModel: ToolTipViewModel,
         insetValue: CGFloat) {
        self.viewModel = viewModel
        self.insetValue = insetValue
    }
}

extension ToolTipTopPath {
    func fixedPath(in rect: CGRect) -> Path {
        Path { path in
            
        }
    }
    
    func flexiblePath(in rect: CGRect) -> Path {
        return viewModel(\.canDrawTail) ? getPathToTailSizeNotOver(in: rect) : getPathToTailSizeOver(in: rect)
    }
    
    func getPathToTailSizeNotOver(in rect: CGRect) -> Path {
        print(#function)
        return viewModel(\.limitBaseLine) ?
        tailSizeNotOverLimitBaseLine(in: rect) :
        tailSizeNotOverBaseLine(in: rect)
    }
    
    func getPathToTailSizeOver(in rect: CGRect) -> Path {
        print(#function)
        return viewModel(\.limitBaseLine) ?
        tailSizeOverLimitBaseLine(in: rect) :
        tailSizeOverBaseLine(in: rect)
    }
}

extension ToolTipTopPath {
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: startPoint.x + (tailSize.width / 2),
                                     y: startPoint.y - tailSize.height))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: startPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius,
                                     y: rect.minY + insetValue))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.minY + cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(270),
                        endAngle: .degrees(0),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                     y: rect.maxY - cornerRadius))

            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius,
                                     y: path.currentPoint?.y ?? rect.maxY - insetValue))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? (rect.minX + insetValue),
                                     y: rect.minY + cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
                                        y: rect.minY + cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
            
            path.closeSubpath()
        }
    }
    
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToLimitBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            
            path.move(to: CGPoint(x: rect.minX + insetValue,
                                  y: rect.minY + insetValue))
            
            path.addLine(to: startPoint)
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: (path.currentPoint?.y ?? 0) - tailSize.height ))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + tailSize.width / 2,
                                     y: startPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX,
                                     y: rect.minY + insetValue))
            
            path.move(to: CGPoint(x: rect.maxX - insetValue,
                                  y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? 0,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.minY))
            
//            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
//                                     y: rect.minY + insetValue))
//
//            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
//                                     y: rect.maxY - insetValue))
//
//            path.addLine(to: CGPoint(x: rect.minX + insetValue,
//                                     y: path.currentPoint?.y ?? rect.maxY - insetValue))
//
//            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
//                                     y: rect.minY))
        }
    }
}

extension ToolTipTopPath {
    func tailSizeOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToSizeOverBaseLine(in: rect)
            
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            
            path.move(to: startPoint)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + cornerRadius + insetValue),
                        radius: cornerRadius - insetValue)
            
            
            path.addArc(tangent1End: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius - insetValue,
                                             y: rect.maxY - insetValue),
                        radius: cornerRadius - insetValue)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: path.currentPoint?.y ?? rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - cornerRadius - insetValue),
                        radius: cornerRadius - insetValue)
            
            path.addArc(tangent1End: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: startPoint,
                        radius: cornerRadius - insetValue)
            
            path.closeSubpath()
            
//            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius - insetValue,
//                                     y: rect.minY + insetValue))
//
//            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
//                                        y: rect.minY + cornerRadius),
//                        radius: cornerRadius - insetValue,
//                        startAngle: .degrees(270),
//                        endAngle: .degrees(0),
//                        clockwise: false)
//
//            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
//                                     y: rect.maxY - cornerRadius - insetValue))
//
//            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
//                                        y: rect.maxY - cornerRadius),
//                        radius: cornerRadius - insetValue,
//                        startAngle: .degrees(0),
//                        endAngle: .degrees(90),
//                        clockwise: false)
//
//            path.addLine(to: CGPoint(x: rect.minX + cornerRadius + insetValue,
//                                     y: path.currentPoint?.y ?? rect.maxY - insetValue))
//
//            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
//                                        y: rect.maxY - cornerRadius),
//                        radius: cornerRadius - insetValue,
//                        startAngle: .degrees(90),
//                        endAngle: .degrees(180),
//                        clockwise: false)
//
//            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
//                                     y: rect.minY + cornerRadius + insetValue))
//
//            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
//                                        y: rect.minY + cornerRadius),
//                        radius: cornerRadius - insetValue,
//                        startAngle: .degrees(180),
//                        endAngle: .degrees(270),
//                        clockwise: false)
//
        }
    }
    
    // tail을 못 그리고 baseLine 제한걸린 Path
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToSizeOverLimitBaseLine(in: rect)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: path.currentPoint?.y ?? rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
                                     y: rect.minY))
            
            path.closeSubpath()
        }
    }
}

extension ToolTipTopPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("center")
            
        case .trailing:
            print("trailing")
            
        case .custom(let length):
            print("custom length : \(length)")
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
        case .center:
            print("center")
            
        case .trailing:
            print("trailing")
            
        case .custom(let length):
            print("custom length : \(length)")
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
}

extension ToolTipTopPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("center")
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
            
        case .trailing:
            print("trailing")
            startPoint = CGPoint(x: rect.maxX - cornerRadius - tailSize.width - insetValue,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            print("custom length : \(length)")
            if length >= 0 {
                let maxPoint = rect.maxX - cornerRadius - tailSize.width - insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: min(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            } else {
                let maxPoint = rect.minX + cornerRadius + insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: max(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            }
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        let tailSize: CGSize = viewModel(\.tailSize)
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("center")
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
            
        case .trailing:
            print("trailing")
            
            startPoint = CGPoint(x: rect.maxX - tailSize.width - insetValue,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            print("custom length : \(length)")
            if length >= 0 {
                let maxPoint = rect.maxX - tailSize.width - insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: min(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            } else {
                let maxPoint = rect.minX + insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: max(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            }
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
}
