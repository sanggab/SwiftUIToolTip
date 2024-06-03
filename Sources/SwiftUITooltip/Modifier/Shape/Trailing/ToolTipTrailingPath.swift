//
//  ToolTipTrailingPath.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

struct ToolTipTrailingPath: PathFeatures {
    @ObservedObject var viewModel: ToolTipViewModel
    var insetValue: CGFloat
    
    init(viewModel: ToolTipViewModel,
         insetValue: CGFloat) {
        self.viewModel = viewModel
        self.insetValue = insetValue
    }
}

// MARK: Decide Path
extension ToolTipTrailingPath {
    func fixedPath(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToFixed(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius: CGFloat = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + tailSize.height ,
                                     y: (path.currentPoint?.y ?? 0) + (tailSize.width / 2)))
            
            path.addLine(to: CGPoint(x: startPoint.x,
                                     y: (path.currentPoint?.y ?? 0) + (tailSize.width / 2)))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - cornerRadius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + cornerRadius,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + cornerRadius),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func flexiblePath(in rect: CGRect) -> Path {
        print(#function)
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

// MARK: TailSize Not Over Path
extension ToolTipTrailingPath {
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: startPoint.x + tailSize.height,
                                     y: startPoint.y + (tailSize.width / 2)))
            
            path.addLine(to: CGPoint(x: startPoint.x,
                                     y: (path.currentPoint?.y ?? 0) + (tailSize.width / 2)))
            
            path.addLine(to: CGPoint(x: startPoint.x,
                                     y: rect.maxY - cornerRadius - insetValue))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius - insetValue,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - cornerRadius - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + cornerRadius + insetValue,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + cornerRadius + insetValue),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToLimitBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            
            path.move(to: CGPoint(x: rect.maxX - insetValue,
                                  y: rect.minY + insetValue))
            
            path.addLine(to: startPoint)
            
            path.addLine(to: CGPoint(x: startPoint.x + tailSize.height,
                                     y: startPoint.y + (tailSize.width / 2)))
            
            path.addLine(to: CGPoint(x: startPoint.x,
                                     y: (path.currentPoint?.y ?? 0) + (tailSize.width / 2)))
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.maxY))
            
            path.move(to: CGPoint(x: rect.maxX - insetValue,
                                  y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minY + insetValue,
                                     y: path.currentPoint?.y ?? 0))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? 0,
                                     y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: rect.maxX,
                                     y: path.currentPoint?.y ?? 0))
        }
    }
}

// MARK: TailSize Over Path
extension ToolTipTrailingPath {
    func tailSizeOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToSizeOverBaseLine(in: rect)
            
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius - insetValue,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - cornerRadius - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + cornerRadius + insetValue,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + cornerRadius + insetValue),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToSizeOverLimitBaseLine(in: rect)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: path.currentPoint?.y ?? 0))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? 0,
                                     y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: rect.maxX,
                                     y: path.currentPoint?.y ?? 0))
            
            path.closeSubpath()
        }
    }
}
