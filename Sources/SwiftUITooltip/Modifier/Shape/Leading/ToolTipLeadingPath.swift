//
//  ToolTipLeadingPath.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

struct ToolTipLeadingPath: PathFeatures {
    @ObservedObject var viewModel: ToolTipViewModel
    var insetValue: CGFloat
    
    init(viewModel: ToolTipViewModel,
         insetValue: CGFloat) {
        self.viewModel = viewModel
        self.insetValue = insetValue
    }
}

// MARK: Decide Path
extension ToolTipLeadingPath {
    func fixedPath(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            let startPoint: CGPoint = getStartPointToFixed(in: rect)
            let tailSize: CGSize = viewModel(\.tailSize)
            let cornerRadius: CGFloat = viewModel(\.cornerRadius)
            let radius: CGFloat = max(0, cornerRadius - insetValue)
            
            path.move(to: startPoint)
            
            path.addLine(to: CGPoint(x: (path.currentPoint?.x ?? 0) - tailSize.height ,
                                     y: (path.currentPoint?.y ?? 0) + (tailSize.width / 2)))
            
            path.addLine(to: CGPoint(x: startPoint.x,
                                     y: (path.currentPoint?.y ?? 0) + (tailSize.width / 2)))
            
            path.addArc(tangent1End: CGPoint(x: rect.minX + insetValue,
                                             y: rect.maxY - insetValue),
                        tangent2End: CGPoint(x: rect.minX + cornerRadius,
                                             y: rect.maxY - insetValue),
                        radius: radius)
            
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
            
            path.closeSubpath()
        }
    }
    
    func flexiblePath(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func getPathToTailSizeNotOver(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func getPathToTailSizeOver(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}

// MARK: TailSize Not Over Path
extension ToolTipLeadingPath {
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}

// MARK: TailSize Over Path
extension ToolTipLeadingPath {
    func tailSizeOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}
