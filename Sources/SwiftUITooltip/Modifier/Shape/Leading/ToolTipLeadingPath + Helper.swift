//
//  ToolTipLeadingPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

// MARK: calculate CornerRadius
extension ToolTipLeadingPath {
    func calCornerRadius(in rect: CGRect) {
        let style = viewModel(\.style)
        let cornerRadius = viewModel(\.cornerRadius)
        let tailSize = viewModel(\.tailSize)
        
        let halfWidth = rect.width / 2
        let halfHeight = rect.height / 2
        let hypotenuse = insetValue * 2
        
        if tailSize.width + hypotenuse + (cornerRadius * 2) > rect.height {
            viewModel.update(\.canDrawTail, false)
            var calHalfMin = min(halfWidth, halfHeight)
            calHalfMin = min(calHalfMin, cornerRadius)
            viewModel.update(\.cornerRadius, calHalfMin)
        } else {
            let drawBaseLine = viewModel(\.tailSize.width) + (cornerRadius * 2) + hypotenuse
            
            if drawBaseLine > rect.height {
                viewModel.update(\.canDrawTail, true)
                var calHalfMin = min(halfWidth, halfHeight)
                calHalfMin = min(calHalfMin, cornerRadius)
                calHalfMin = min(calHalfMin, cornerRadius - (drawBaseLine - rect.height) / 2)
                
                viewModel.update(\.cornerRadius, calHalfMin)
            } else {
                viewModel.update(\.canDrawTail, true)
                viewModel.update(\.cornerRadius, min(viewModel(\.cornerRadius), halfWidth))
            }
        }
        
        // MARK: - strokeBorder에서 lineJoin이 miter이면서 cornerRadius가 insetValue보다 작거나 같은 경우, cornerRadius는 적용되지 않는다.
        if style == .strokeBorder || style == .fillWithStrokeBorder,  insetValue >= cornerRadius && viewModel(\.strokeStyle).lineJoin == .miter {
            viewModel.update(\.cornerRadius, 0)
            viewModel.update(\.limitBaseLine, true)
        }
        
    }
}

// MARK: Fixed Mode Start Point
extension ToolTipLeadingPath {
    func getStartPointToFixed(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + cornerRadius + insetValue + movePoint)
        case .center:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2) + movePoint)
        case .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.maxY - cornerRadius - tailSize.width - insetValue + movePoint)
        case .custom(let length):
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2) + length + movePoint)
        default:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2) + movePoint)
        }
        
        return startPoint
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipLeadingPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        let topPoint = rect.minY + cornerRadius + insetValue
        let centerPoint = rect.midY - (tailSize.width / 2)
        let bottomPoint = rect.maxY - cornerRadius - tailSize.width - insetValue
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            let condition1 = max(topPoint, topPoint + movePoint)
            let condition2 = min(condition1, bottomPoint)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        case .center:
            let condition1 = max(topPoint, centerPoint + movePoint)
            let condition2 = min(condition1, bottomPoint)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        case .bottom:
            let condition1 = min(bottomPoint, bottomPoint + movePoint)
            let condition2 = max(topPoint, condition1)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        default:
            let condition1 = min(topPoint, centerPoint + movePoint)
            let condition2 = max(condition1, bottomPoint)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        }
        
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        let tailSize: CGSize = viewModel(\.tailSize)
        
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        let topPoint = rect.minY + insetValue
        let centerPoint = rect.midY - (tailSize.width / 2)
        let bottomPoint = rect.maxY - tailSize.width - insetValue
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            let condition1 = max(topPoint, topPoint + movePoint)
            let condition2 = min(condition1, bottomPoint)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        case .center:
            let condition1 = max(topPoint, centerPoint + movePoint)
            let condition2 = min(condition1, bottomPoint)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        case .bottom:
            let condition1 = min(bottomPoint, bottomPoint + movePoint)
            let condition2 = max(topPoint, condition1)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        default:
            let condition1 = min(topPoint, centerPoint + movePoint)
            let condition2 = max(condition1, bottomPoint)
            
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: condition2)
        }
        
        return startPoint
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipLeadingPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .custom, .top, .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + cornerRadius + insetValue)
        }
        
        return startPoint
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .custom, .top, .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
        }
        
        return startPoint
    }
}
