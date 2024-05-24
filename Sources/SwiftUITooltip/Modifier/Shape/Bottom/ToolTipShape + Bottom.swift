//
//  ToolTipShape + Bottom.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/22.
//

import SwiftUI


// MARK: - tailPostion bottom Path
extension ToolTipShape {
    
    func fixedBottomPath(in rect: CGRect) -> Path {
        Path { path in
            
        }
//        Path { path in
//
//            path.move(to: CGPoint(x: rect.midX + (model.tailSize.width / 2) + model.movePoint,
//                                  y: rect.maxY - insetValue))
//
//            path.addLine(to: CGPoint(x: rect.midX + model.movePoint,
//                                     y: rect.maxY + model.tailSize.height))
//
//            path.addLine(to: CGPoint(x: rect.midX - (model.tailSize.width / 2) + model.movePoint,
//                                     y: rect.maxY - insetValue))
//
//            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
//                                             y: rect.maxY - insetValue),
//                        tangent2End: (CGPoint(x: rect.minX + insetValue,
//                                              y: rect.maxY - model.cornerRadius)),
//                        radius: model.cornerRadius)
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
//            path.closeSubpath()
//        }
    }
    
    func flexibleBottomPath(in rect: CGRect) -> Path {
        Path { path in
            
        }
    }
}
