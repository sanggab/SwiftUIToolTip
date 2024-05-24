//
//  ToolTipShape + Leading.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/22.
//

import SwiftUI

// MARK: - tailPostion leading Path
extension ToolTipShape {
    
    func fixedLeadingPath(in rect: CGRect) -> Path {
        Path { path in
            
        }
//        Path { path in
//
//            path.move(to: CGPoint(x: rect.minX + insetValue,
//                                  y: rect.midY + (model.tailSize.width / 2) + model.movePoint))
//
//            path.addLine(to: CGPoint(x: rect.minX - model.tailSize.height + insetValue,
//                                     y: rect.midY + model.movePoint))
//
//            path.addLine(to: CGPoint(x: rect.minX + insetValue,
//                                     y: rect.midY - (model.tailSize.width / 2) + model.movePoint))
//
//            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
//                                             y: rect.minY + insetValue),
//                        tangent2End: CGPoint(x: rect.minX + model.cornerRadius,
//                                             y: rect.minY + insetValue),
//                        radius: model.cornerRadius)
//
//            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
//                                             y: rect.minY + insetValue),
//                        tangent2End: CGPoint(x: rect.maxX - insetValue,
//                                             y: rect.minY + model.cornerRadius),
//                        radius: model.cornerRadius)
//
//            path.addArc(tangent1End: CGPoint(x: rect.maxX - insetValue,
//                                             y: rect.maxY - insetValue),
//                        tangent2End: CGPoint(x: rect.maxX - model.cornerRadius,
//                                             y: rect.maxY - insetValue),
//                        radius: model.cornerRadius)
//
//            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
//                                             y: rect.maxY - insetValue),
//                        tangent2End: CGPoint(x: rect.minX + insetValue,
//                                             y: rect.midY + (model.tailSize.width / 2) + model.movePoint),
//                        radius: model.cornerRadius)
//
//            path.closeSubpath()
//        }
    }
    
    func flexibleLeadingPath(in rect: CGRect) -> Path {
        calCornerRadius(in: rect)
        return Path { path in
            
        }
    }
}
