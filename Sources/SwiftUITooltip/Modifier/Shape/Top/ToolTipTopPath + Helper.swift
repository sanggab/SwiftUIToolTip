//
//  ToolTipTopPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

// MARK: calculate CornerRadius
extension ToolTipTopPath {
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

extension ToolTipTopPath {
    func getStartPointToFixed(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        let movePoint: CGFloat = viewModel(\.movePoint)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue + movePoint,
                                 y: rect.minY + insetValue)
            
        case .center:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2) + movePoint,
                                 y: rect.minY + insetValue)
            
        case .trailing:
            startPoint = CGPoint(x: rect.maxX - cornerRadius - tailSize.width - insetValue + movePoint,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2) + length + movePoint,
                                 y: rect.minY + insetValue)
        default:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2) + movePoint,
                                 y: rect.minY + insetValue)
        }
     
        return startPoint
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipTopPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
            
        case .trailing:
            startPoint = CGPoint(x: rect.maxX - cornerRadius - tailSize.width - insetValue,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            if length >= 0 {
                let maxPoint = rect.maxX - cornerRadius - tailSize.width - insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: min(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            } else {
                let maxPoint = rect.minX + cornerRadius + insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: max(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            }
        default:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
        }
     
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
            
        case .trailing:
            startPoint = CGPoint(x: rect.maxX - tailSize.width - insetValue,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            if length >= 0 {
                let maxPoint = rect.maxX - tailSize.width - insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: min(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
                
            } else {
                let maxPoint = rect.minX + insetValue
                let calPoint = rect.midX - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: max(maxPoint, calPoint),
                                     y: rect.minY + insetValue)
            }
        default:
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
        }
     
        return startPoint
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipTopPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .custom, .top, .bottom:
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.minY + insetValue)
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
