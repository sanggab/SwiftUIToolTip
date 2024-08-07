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
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + cornerRadius + insetValue)
        case .center:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        case .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.maxY - cornerRadius - tailSize.width - insetValue)
        case .custom(let length):
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2) + length)
        default:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        }
        
        return startPoint
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipLeadingPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + cornerRadius + insetValue)
        case .center:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        case .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.maxY - cornerRadius - tailSize.width - insetValue)
        case .custom(let length):
            if length >= 0 {
                let maxPoint = rect.maxY - cornerRadius - tailSize.width - insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: rect.minX + insetValue,
                                     y: min(maxPoint, calPoint))
                
            } else {
                let maxPoint = rect.minY + cornerRadius + insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length

                startPoint = CGPoint(x: rect.minX + insetValue,
                                     y: max(maxPoint, calPoint))
            }
        default:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        }
        
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
        case .center:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        case .bottom:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.maxY - tailSize.width - insetValue)
        case .custom(let length):
            if length >= 0 {
                let maxPoint = rect.maxY - tailSize.width - insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: rect.minX + insetValue,
                                     y: min(maxPoint, calPoint))
                
            } else {
                let maxPoint = rect.minY + insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: rect.minX + insetValue,
                                     y: max(maxPoint, calPoint))
            }
        default:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.midY - (tailSize.width / 2))
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
