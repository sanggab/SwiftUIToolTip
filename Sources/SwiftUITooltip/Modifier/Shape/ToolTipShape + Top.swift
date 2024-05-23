//
//  ToolTipShape + Top.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/22.
//

import SwiftUI

struct ToolTipMovePoint {
    static var zero = ToolTipMovePoint(leadingPoint: .zero, topPoint: .zero, trailingPoint: .zero)
    
    var leadingPoint: CGFloat
    var topPoint: CGFloat
    var trailingPoint: CGFloat
}

private extension ToolTipShape {
    
    func getFlexibleMovePoint(in rect: CGRect) -> CGFloat {
        print("rect : \(rect)")
//        print("tailAlignment : \(model.tailAlignment)")
//        print("cornerRadius : \(model.cornerRadius)")
//        print("tailPosition : \(model.tailPosition)")
        
        switch model.tailAlignment {
        case .leading:
            print("leading")
            return .zero
        case .center:
            print("center")
            return rect.midX - (model.tailSize.width / 2)
        case .trailing:
            print("trailing")
            print("rect.maxX : \(rect.maxX)")
            print("model.cornerRadius : \(model.cornerRadius)")
            print("model.tailSize.width : \(model.tailSize.width)")
            print("insetValue : \(insetValue)")
            if rect.width < model.tailSize.width + model.cornerRadius {
                print("hi")
                return .zero
            }
            
            let calPoint = rect.maxX - (model.cornerRadius + model.tailSize.width + insetValue)
            print("calPoint : \(calPoint)")
            return calPoint
        case .custom(let length):
            print("custom length : \(length)")
            return .zero
        }
    }
    
    func testPoint(in rect: CGRect) -> ToolTipMovePoint {
        
        switch model.tailAlignment {
        case .leading:
            return .zero
        case .center:
            return .zero
        case .trailing:
            print("rect : \(rect)")
            return .zero
        case .custom(let length):
            return .zero
        }
    }
}

// MARK: - tailPostion top Path
extension ToolTipShape {
    
    func fixedTopPath(in rect: CGRect) -> Path {
        Path { path in
            
        }
    }
    
    func flexibleTopPath(in rect: CGRect) -> Path {
        calCornerRadius(in: rect)
        
        return viewModel(\.canDrawTail) ? getPathToTailSizeNotOver(in: rect) : getPathToTailSizeOver(in: rect)
        
//        if viewModel(\.tailSize.width) > rect.width {
//            print("tail을 무시하고 그냥 cornerRadius가 적용된 Path를 그리자")
//            return getPathToTailSizeOver(in: rect)
//        } else {
//            print("width에 tailSize를 그릴 순 있다")
//
//            return Path()
//        }
        
//        return Path { path in
//            print("corenrRaidus: \(viewModel(\.cornerRadius))")
//            
//            let drawBaseLine = viewModel(\.tailSize.width) + viewModel(\.cornerRadius) * 2
//            
//            print("drawBaseLine : \(drawBaseLine)")
//            
//            
//        }
    }
}

private extension ToolTipShape {
    
    func getPathToTailSizeOver(in rect: CGRect) -> Path {
        Path { path in
            
        }
    }
    
    func getPathToTailSizeNotOver(in rect: CGRect) -> Path {
        Path { path in
            let startPoint = calFlexibleMovePointPositionTop(in: rect)
            
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.minY + cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(270),
                        endAngle: .degrees(0),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - insetValue,
                                     y: rect.maxY - cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius,
                                     y: rect.maxY - insetValue))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minX + insetValue,
                                     y: rect.minY + cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius,
                                        y: rect.minY + cornerRadius),
                        radius: cornerRadius - insetValue,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
            
            path.addLine(to: startPoint)
            
            path.addLine(to: CGPoint(x: startPoint.x + (viewModel(\.tailSize).width / 2),
                                     y: rect.minY - viewModel(\.tailSize).height + insetValue))
                         
            path.addLine(to: CGPoint(x: startPoint.x + viewModel(\.tailSize).width,
                                     y: rect.minY + insetValue))
                         
            path.closeSubpath()
        }
    }
    
    func calFlexibleMovePointPositionTop(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("Leading")
            startPoint = CGPoint(x: rect.minX + viewModel(\.cornerRadius),
                                 y: rect.minY + insetValue)
            
            print("startPoint : \(startPoint)")
            
            return startPoint
        case .trailing:
            print("Trailing")
            let maxX = rect.maxX - viewModel(\.cornerRadius)
            let startX = maxX - viewModel(\.tailSize).width
            print("maxX : \(maxX)")
            print("startX : \(startX)")
            
            startPoint = CGPoint(x: startX,
                                  y: rect.minY + insetValue)
            
            print("startPoint : \(startPoint)")
            return startPoint
        case .center:
            print("Center")
            startPoint = CGPoint(x: rect.midX - (viewModel(\.tailSize).width / 2),
                                 y: rect.minY + insetValue)
            
            print("startPoint : \(startPoint)")
            return startPoint
        case .custom(let length):
            print("Custom : \(length)")
            
            if length >= 0 {
                print("center에서 오른쪽으로 이동")
                let maxX = rect.maxX - viewModel(\.cornerRadius)
                let pointX = rect.midX - (viewModel(\.tailSize.width) / 2)
                let baseLineX = pointX + length
                print("maxX : \(maxX)")
                print("pointX : \(pointX)")
                print("baseLineX : \(baseLineX)")
                
//                let newMax = min(new + viewModel(\.tailSize.width), maxX)
                if (baseLineX + viewModel(\.tailSize).width) > maxX {
                    print("length가 maxX를 침범함")
                    startPoint = CGPoint(x: maxX - viewModel(\.tailSize).width ,
                                         y: rect.minY + insetValue)
                } else {
                    print("length가 maxX를 침범안함")
                    startPoint = CGPoint(x: baseLineX,
                                         y: rect.minY + insetValue)
                }
                
            } else {
                print("center에서 왼쪽으로 이동")
                let maxX = rect.minX + viewModel(\.cornerRadius)
                let pointX = rect.midX - (viewModel(\.tailSize.width) / 2)
                let baseLineX = pointX + length
                
                if baseLineX > maxX {
                    print("baseLineX가 maxX보다 큼")
                    startPoint = CGPoint(x: baseLineX,
                                         y: rect.minY + insetValue)
                } else {
                    print("baseLineX가 maxX보다 작음")
                    startPoint = CGPoint(x: maxX,
                                         y: rect.minY + insetValue)
                }
            }
            
            print("startPoint : \(startPoint)")
            return startPoint
        }
    }
}

public extension ToolTipShape {
    
}
