//
//  SwiftUIView.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public struct ToolTipShape: Shape, InsettableShape {
    
    @Environment(\.layoutDirection) private var layoutDirection
    
    public var radius: CGFloat
    public var tailSize: CGSize
    public var tailPosition: TailPosition
    public var movePoint: CGFloat
    
    public var insetValue: CGFloat = 0
    
    public init(radius: CGFloat,
                tailSize: CGSize,
                tailPosition: TailPosition,
                movePoint: CGFloat) {
        self.radius = radius
        self.tailSize = tailSize
        self.tailPosition = tailPosition
        self.movePoint = movePoint
    }
    
    public func path(in rect: CGRect) -> Path {
        switch tailPosition {
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
            
            path.move(to: CGPoint(x: rect.midX - (tailSize.width / 2) + movePoint,
                                  y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: rect.midX + movePoint,
                                     y: rect.minY - tailSize.height + insetValue))
            
            path.addLine(to: CGPoint(x: rect.midX + (tailSize.width / 2) + movePoint,
                                     y: rect.minY + insetValue))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + radius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - radius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - radius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + radius,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailLeadingPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.minX + insetValue,
                                  y: rect.midY + (tailSize.width / 2) + movePoint))
            
            path.addLine(to: CGPoint(x: rect.minX - tailSize.height + insetValue,
                                     y: rect.midY + movePoint))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.midY - (tailSize.width / 2) + movePoint))
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + radius,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + radius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - radius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.midY + (tailSize.width / 2) + movePoint),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailTrailingPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.maxX - insetValue,
                                  y: rect.midY - (tailSize.width / 2) + movePoint))
            
            path.addLine(to: CGPoint(x: rect.maxX + tailSize.height - insetValue,
                                     y: rect.midY + movePoint))
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.midY + (tailSize.width / 2) + movePoint))
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - radius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - radius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + radius,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.midY - (tailSize.width / 2) + movePoint),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
    
    func tailBottomPath(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.midX + (tailSize.width / 2) + movePoint,
                                  y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.midX + movePoint,
                                     y: rect.maxY + tailSize.height))
            
            path.addLine(to: CGPoint(x: rect.midX - (tailSize.width / 2) + movePoint,
                                     y: rect.maxY - insetValue))
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: (CGPoint(x: rect.minX + insetValue,
                                              y: rect.maxY - radius)),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.minX + radius,
                                             y: rect.minY + insetValue),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + insetValue),
                        tangent2End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.minY + radius),
                        radius: radius)
            
            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.maxX - radius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
            path.closeSubpath()
        }
    }
}
