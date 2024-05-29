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
            let startPoint: CGPoint = getStartPointToBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: startPoint.x + (tailSize.width / 2) - insetValue,
                                     y: startPoint.y - tailSize.height))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2) - insetValue,
                                     y: startPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius - insetValue,
                                     y: startPoint.y))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.minY + cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(270),
                        endAngle: .degrees(0),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? (rect.maxX - insetValue),
                                     y: rect.maxY - insetValue - cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue + cornerRadius,
                                     y: path.currentPoint?.y ?? (rect.maxY - insetValue)))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? (rect.minX + insetValue),
                                     y: rect.minY + insetValue + cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
                                        y: rect.minY + cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
            
            path.closeSubpath()
        }
    }
    
    // MARK: - Path를 그릴 때, 나는 맨 처음 좌표인 minX에 y좌표를 지정하고 addLine으로 maxX 까지 그린 다음에 밑으로 내려서 사각형을 만들려고 했더니, strokeBorder인 경우에 path가 maxX 좌표 오른쪽으로 그려지는걸 확인. 결국 outline으로 그려진다
    // MARK: - 근데 다시 그려보니 중심으로 그리기 때문에 insetValue를 빼서 그리면 중간만큼 그리기 때문에 그 중간을 기점으로 lineWidth만큼 path를 그리기 때문에 맞게 그려진다.
    // tail을 그리지만 baseLine 제한이 걸린 Path - cornerRadius 0
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToLimitBaseLine(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + (tailSize.width / 2),
                                     y: (path.currentPoint?.y ?? 0) - tailSize.height ))
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) + tailSize.width / 2,
                                     y: startPoint.y))
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.minY + insetValue))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.maxX - insetValue,
                                     y: rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: path.currentPoint?.y ?? rect.maxY - insetValue))
            
            path.addLine(to: CGPoint(x: path.currentPoint?.x ?? rect.minX + insetValue,
                                     y: rect.minY))
        }
    }
}

// MARK: - Tail Size Over Path
private extension ToolTipShape {
    
    // tail을 못 그리지만 baseLine 제한은 안걸린 Path
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
