//
//  ToolTipBottomPath.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

struct ToolTipBottomPath: PathFeatures {
    @ObservedObject var viewModel: ToolTipViewModel
    var insetValue: CGFloat
    
    init(viewModel: ToolTipViewModel,
         insetValue: CGFloat) {
        self.viewModel = viewModel
        self.insetValue = insetValue
    }
}

// MARK: Decide Path
extension ToolTipBottomPath {
    func fixedPath(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint: CGPoint = getStartPointToFixed(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius: CGFloat = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? startPoint.x) + (tailSize.width / 2),
                                     y: (path.currentPoint?.y ?? 0) + tailSize.height))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: startPoint.y))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - cornerRadius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + cornerRadius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func flexiblePath(in rect: CGRect) -> Path {
        return viewModel(\.canDrawTail) ? getPathToTailSizeNotOver(in: rect) : getPathToTailSizeOver(in: rect)
    }
    
    func getPathToTailSizeNotOver(in rect: CGRect) -> Path {
        return viewModel(\.limitBaseLine) ?
        tailSizeNotOverLimitBaseLine(in: rect) :
        tailSizeNotOverBaseLine(in: rect)
    }
    
    func getPathToTailSizeOver(in rect: CGRect) -> Path {
        return viewModel(\.limitBaseLine) ?
        tailSizeOverLimitBaseLine(in: rect) :
        tailSizeOverBaseLine(in: rect)
    }
}

// MARK: TailSize Not Over Path
extension ToolTipBottomPath {
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint: CGPoint = getStartPointToBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: startPoint.x + (tailSize.width / 2),
                                     y: startPoint.y + tailSize.height))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: startPoint.y))
            
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - cornerRadius - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius - insetValue,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + cornerRadius + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + cornerRadius + insetValue,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint: CGPoint = getStartPointToLimitBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            
            path.move(to: CGPoint(x: rect.minX + insetValue,
                                  y: rect.maxY - insetValue))
            
            path.addLine(to: startPoint)
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: (path.currentPoint?.y ?? 0) + tailSize.height))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: startPoint.y))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY),
                        radius: .zero)

            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.midX,
                                             y: rect.minY + insetValue),
                        radius: .zero)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.midY),
                        radius: .zero)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.midX,
                                             y: rect.maxY - insetValue),
                        radius: .zero)
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.maxY))
        }
    }
}

// MARK: TailSize Over Path
extension ToolTipBottomPath {
    func tailSizeOverBaseLine(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint: CGPoint = getStartPointToSizeOverBaseLine(in: rect)
            
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - cornerRadius - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - cornerRadius - insetValue,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: path.currentPoint?.y ?? rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + cornerRadius + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: startPoint,
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint: CGPoint = getStartPointToSizeOverLimitBaseLine(in: rect)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.maxY - insetValue))
            
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                     y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: path.currentPoint?.y ?? rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
                                     y: rect.maxY))
            
            path.closeSubpath()
        }
    }
}
