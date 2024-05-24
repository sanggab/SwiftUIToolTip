//
//  TopFlexiblePath.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/24.
//

import SwiftUI

// 중요한 사실. strokeBorder에선 corenrRadius가 insetValue의 초과해야 적용된다.

extension ToolTipShape {
    
    func flexibleTopPath(in rect: CGRect) -> Path {
        calCornerRadius(in: rect)
        
        return viewModel(\.canDrawTail) ? getPathToTailSizeNotOver(in: rect) : getPathToTailSizeOver(in: rect)
    }
}

extension ToolTipShape {
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

// MARK: - Tail Size Not Over
private extension ToolTipShape {
    
    // tail을 그리면서 baseLine 제한은 안걸린 Path
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = calLimitBaseLineStratPoint(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            
//            path.move(to: startPoint)
//            
//            path.addLine(to: CGPoint(x: startPoint.x + (tailSize.width / 2),
//                                     y: startPoint.y - tailSize.height))
//            
//            path.addLine(to: CGPoint(x: startPoint.x + tailSize.width,
//                                     y: startPoint.y))
            
//            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius - insetValue ,
//                                     y: rect.minY + insetValue))
            
//            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
//                                             y: rect.minY + insetValue),
//                        tangent2End: CGPoint(x: rect.minX + cornerRadius,
//                                             y: rect.minY + cornerRadius),
//                        radius: cornerRadius)
        }
    }
    
    // tail을 그리지만 baseLine 제한이 걸린 Path - cornerRadius 0
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = calLimitBaseLineStratPoint(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            
            path.move(to: CGPoint(x: rect.minX + insetValue,
                                  y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: startPoint.x,
                                     y: startPoint.y))
            
//            path.move(to: CGPoint(x: startPoint.x,
//                                  y: startPoint.y))
//            
            path.addLine(to: CGPoint(x: startPoint.x + (tailSize.width / 2),
                                     y: startPoint.y - tailSize.height))
            
            path.addLine(to: CGPoint(x: startPoint.x + tailSize.width,
                                     y: startPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: startPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.minY + insetValue))
            
//            path.closeSubpath()
            
//            path.addLine(to: CGPoint(x: rect.m,
//                                     y: <#T##Int#>))
            
//            path.move(to: startPoint)
//            
//            path.addLine(to: CGPoint(x: startPoint.x + (tailSize.width / 2),
//                                     y: startPoint.y - tailSize.height))
//            
//            path.addLine(to: CGPoint(x: startPoint.x + tailSize.width,
//                                     y: startPoint.y))
//            
//            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius - insetValue ,
//                                     y: rect.minY + insetValue))
//            
//            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
//                                             y: rect.minY + insetValue),
//                        tangent2End: CGPoint(x: rect.minX + cornerRadius,
//                                             y: rect.minY + cornerRadius),
//                        radius: cornerRadius)
        }
    }
}

// MARK: - Tail Size Over Path
private extension ToolTipShape {
    
    // tail을 못 그리지만 baseLine 제한은 안걸린 Path
    func tailSizeOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    // tail을 못 그리고 baseLine 제한걸린 Path
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}
