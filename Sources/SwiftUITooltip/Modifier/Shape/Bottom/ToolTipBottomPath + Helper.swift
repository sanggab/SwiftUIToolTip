//
//  ToolTipBottomPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

// MARK: calculate CornerRadius
extension ToolTipBottomPath {
    func calCornerRadius(in rect: CGRect) {
        
        let style = viewModel(\.style)
        let cornerRadius = viewModel(\.cornerRadius)
        let tailSize = viewModel(\.tailSize)
        
        let halfWidth = rect.width / 2
        let halfHeight = rect.height / 2
        let hypotenuse = insetValue * 2
        
        if tailSize.width + hypotenuse + (cornerRadius * 2) > rect.width {
            viewModel.update(\.canDrawTail, false)
            var calHalfMin = min(halfWidth, halfHeight)
            calHalfMin = min(calHalfMin, cornerRadius)
            viewModel.update(\.cornerRadius, calHalfMin)
        } else {
            let drawBaseLine = tailSize.width + (cornerRadius * 2) + hypotenuse
            
            if drawBaseLine > rect.width {
                viewModel.update(\.canDrawTail, true)
                var calHalfMin = min(halfWidth, halfHeight)
                calHalfMin = min(calHalfMin, cornerRadius)
                calHalfMin = min(calHalfMin, cornerRadius - (drawBaseLine - rect.width) / 2)
                
                viewModel.update(\.cornerRadius, calHalfMin)
            } else {
                viewModel.update(\.canDrawTail, true)
                viewModel.update(\.cornerRadius, min(viewModel(\.cornerRadius), halfHeight))
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
extension ToolTipBottomPath {
    func getStartPointToFixed(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue + movePoint,
                                 y: rect.maxY - insetValue)
            
        case .center:
            
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2) + movePoint,
                                 y: rect.maxY - insetValue)
            
        case .trailing:
            
            startPoint = CGPoint(x: rect.maxX - cornerRadius - tailSize.width - insetValue + movePoint,
                                 y: rect.maxY - insetValue)
            
        default:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2) + movePoint,
                                 y: rect.maxY - insetValue)
        }
        
        return startPoint
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipBottomPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        let leadingPoint = rect.minX + cornerRadius + insetValue
        let centerPoint = rect.midX - (tailSize.width / 2)
        let trailingPoint = rect.maxX - cornerRadius - tailSize.width - insetValue
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            let condition1 = max(leadingPoint, leadingPoint + movePoint)
            let condition2 = min(condition1, trailingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
            
        case .center:
            let condition1 = max(leadingPoint, centerPoint + movePoint)
            let condition2 = min(condition1, trailingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
            
        case .trailing:
            let condition1 = min(trailingPoint, trailingPoint + movePoint)
            let condition2 = max(leadingPoint, condition1)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
            
        default:
            let condition1 = max(leadingPoint, centerPoint + movePoint)
            let condition2 = min(condition1, trailingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
        }
        
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        let tailSize: CGSize = viewModel(\.tailSize)
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        let leadingPoint = rect.minX + insetValue
        let centerPoint = rect.midX - (tailSize.width / 2)
        let trailingPoint = rect.maxX - tailSize.width - insetValue
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            let condition1 = max(leadingPoint, leadingPoint + movePoint)
            let condition2 = min(condition1, trailingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
            
        case .center:
            let condition1 = max(leadingPoint, centerPoint + movePoint)
            let condition2 = min(condition1, trailingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
            
        case .trailing:
            let condition1 = min(trailingPoint, trailingPoint + movePoint)
            let condition2 = max(condition1, leadingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
            
        default:
            let condition1 = max(leadingPoint, centerPoint + movePoint)
            let condition2 = min(condition1, trailingPoint)
            
            startPoint = CGPoint(x: condition2,
                                 y: rect.maxY - insetValue)
        }
        
        return startPoint
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipBottomPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .top, .bottom:
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.maxY - insetValue)
        }
        
        return startPoint
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .top, .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.maxY - insetValue)
        }
        
        return startPoint
    }
}
