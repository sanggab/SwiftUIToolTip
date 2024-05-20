//
//  ToolTipShape.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public struct ToolTipShape: Shape, InsettableShape {
    @Environment(\.layoutDirection) private var layoutDirection
    
    public var model: ToolTipModel
    
    public init(model: ToolTipModel) {
        self.model = model
    }
    
    public var insetValue: CGFloat = 0
    
    public func path(in rect: CGRect) -> Path {
        switch model.tailPosition {
        case .top:
            return tailTopPath(in: rect)
        case .leading:
            if layoutDirection == .leftToRight {
                return tailLeadingPath(in: rect)
            } else {
                return tailTrailingPath(in: rect)
            }
        case .trailing:
            if layoutDirection == .leftToRight {
                return tailTrailingPath(in: rect)
            } else {
                return tailLeadingPath(in: rect)
            }
        case .bottom:
            return tailBottomPath(in: rect)
        }
    }
    
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var tooltip = self
        tooltip.insetValue = amount
        return tooltip
    }
}

private extension ToolTipShape {
    
    func tailTopPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.midX - (model.tailSize.width / 2) + model.movePoint,
                                  y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: rect.midX + model.movePoint,
                                     y: rect.minY - model.tailSize.height + insetValue))
            
            path.addLine(to: CGPoint(x: rect.midX + (model.tailSize.width / 2) + model.movePoint,
                                     y: rect.minY + insetValue))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + model.cornerRadius),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - model.cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - model.cornerRadius),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + model.cornerRadius,
                                             y: rect.minY + insetValue),
                        radius: model.cornerRadius)
            
            path.closeSubpath()
        }
    }
    
    func tailLeadingPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.minX + insetValue,
                                  y: rect.midY + (model.tailSize.width / 2) + model.movePoint))
            
            path.addLine(to: CGPoint(x: rect.minX - model.tailSize.height + insetValue,
                                     y: rect.midY + model.movePoint))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.midY - (model.tailSize.width / 2) + model.movePoint))
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + model.cornerRadius,
                                             y: rect.minY + insetValue),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + model.cornerRadius),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - model.cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.midY + (model.tailSize.width / 2) + model.movePoint),
                        radius: model.cornerRadius)
            
            path.closeSubpath()
        }
    }
    
    func tailTrailingPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.maxX - insetValue,
                                  y: rect.midY - (model.tailSize.width / 2) + model.movePoint))
            
            path.addLine(to: CGPoint(x: rect.maxX + model.tailSize.height - insetValue,
                                     y: rect.midY + model.movePoint))
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.midY + (model.tailSize.width / 2) + model.movePoint))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - model.cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - model.cornerRadius),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + model.cornerRadius,
                                             y: rect.minY + insetValue),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.midY - (model.tailSize.width / 2) + model.movePoint),
                        radius: model.cornerRadius)
            
            path.closeSubpath()
        }
    }
    
    func tailBottomPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.midX + (model.tailSize.width / 2) + model.movePoint,
                                  y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.midX + model.movePoint,
                                     y: rect.maxY + model.tailSize.height))
            
            path.addLine(to: CGPoint(x: rect.midX - (model.tailSize.width / 2) + model.movePoint,
                                     y: rect.maxY - insetValue))
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: (CGPoint(x: rect.minX + insetValue,
                                              y: rect.maxY - model.cornerRadius)),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + model.cornerRadius,
                                             y: rect.minY + insetValue),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + model.cornerRadius),
                        radius: model.cornerRadius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - model.cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: model.cornerRadius)
            
            path.closeSubpath()
        }
    }
}
