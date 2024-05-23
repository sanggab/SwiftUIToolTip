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
        
        print("cornerRadius : \(viewModel(\.cornerRadius))")
        
        if viewModel(\.tailSize.width) > rect.width {
            print("tail을 무시하고 그냥 cornerRadius가 적용된 Path를 그리자")
            return getPathToTailSizeOver(in: rect)
        } else {
            print("width에 tailSize를 그릴 순 있다")
            
            return Path()
        }
        
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
            
        }
    }
}

public extension ToolTipShape {
    
}
