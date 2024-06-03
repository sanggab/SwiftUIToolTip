//
//  ToolTipTrailingPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

// MARK: calculate CornerRadius
extension ToolTipTrailingPath {
    func calCornerRadius(in rect: CGRect) {
        print("=======================================")
        print("resetCornenRadius rect : \(rect)")
        print("cornerRadius : \(viewModel(\.cornerRadius))")
        print("insetValue : \(insetValue)")
        
        let style = viewModel(\.style)
        let cornerRadius = viewModel(\.cornerRadius)
        let tailSize = viewModel(\.tailSize)
        
        let halfWidth = rect.width / 2
        let halfHeight = rect.height / 2
        let hypotenuse = insetValue * 2
        print("hypotenuse : \(hypotenuse)")
        
        if tailSize.width + hypotenuse + (cornerRadius * 2) > rect.height {
            print("해당 height에 tail을 그릴 순 없으니 그냥 cornerRadius만 갱신시켜보자")
            viewModel.update(\.canDrawTail, false)
            var calHalfMin = min(halfWidth, halfHeight)
            calHalfMin = min(calHalfMin, cornerRadius)
            viewModel.update(\.cornerRadius, calHalfMin)
        } else {
            let drawBaseLine = viewModel(\.tailSize.width) + (cornerRadius * 2) + hypotenuse
            print("drawBaseLine : \(drawBaseLine)")
            
            if drawBaseLine > rect.height {
                print("현재 입력한 데이터로는 이상하다 cornerRadius 재정의")
                viewModel.update(\.canDrawTail, true)
                var calHalfMin = min(halfWidth, halfHeight)
                calHalfMin = min(calHalfMin, cornerRadius)
                calHalfMin = min(calHalfMin, cornerRadius - (drawBaseLine - rect.height) / 2)
                
                viewModel.update(\.cornerRadius, calHalfMin)
            } else {
                print("음음 그냥 통과인 것 같지만 cornerRadius가 halfWidth하고 비교해서 재정립 해야한다.")
                viewModel.update(\.canDrawTail, true)
                viewModel.update(\.cornerRadius, min(viewModel(\.cornerRadius), halfWidth))
            }
        }
        
        // MARK: - strokeBorder에서 lineJoin이 miter이면서 cornerRadius가 insetValue보다 작거나 같은 경우, cornerRadius는 적용되지 않는다.
        if style == .strokeBorder || style == .fillWithStrokeBorder,  insetValue >= cornerRadius && viewModel(\.strokeStyle).lineJoin == .miter {
            print("cornerRadius 0으로 만든다")
            viewModel.update(\.cornerRadius, 0)
            viewModel.update(\.limitBaseLine, true)
        }
        
        print("계산끝난 cornerRadius : \(viewModel(\.cornerRadius))")
    }
}

// MARK: Fixed Mode Start Point
extension ToolTipTrailingPath {
    func getStartPointToFixed(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.minY + cornerRadius + insetValue)
        case .center:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        case .bottom:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.maxY - cornerRadius - tailSize.width - insetValue)
        case .custom(let length):
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2) + length)
        default:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        }
        
        print("startPoint : \(startPoint)")
        return startPoint
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipTrailingPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.minY + cornerRadius + insetValue)
        case .center:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        case .bottom:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.maxY - cornerRadius - tailSize.width - insetValue)
        case .custom(let length):
            if length >= 0 {
                let maxPoint = rect.maxY - cornerRadius - tailSize.width - insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: rect.maxX - insetValue,
                                     y: min(maxPoint, calPoint))
                
            } else {
                let maxPoint = rect.minY + cornerRadius + insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length

                startPoint = CGPoint(x: rect.maxX - insetValue,
                                     y: max(maxPoint, calPoint))
            }
        default:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        }
        
        print("startPoint : \(startPoint)")
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .top:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.minY + insetValue)
        case .center:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        case .bottom:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.maxY - tailSize.width - insetValue)
        case .custom(let length):
            if length >= 0 {
                let maxPoint = rect.maxY - tailSize.width - insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: rect.maxX - insetValue,
                                     y: min(maxPoint, calPoint))
                
            } else {
                let maxPoint = rect.minY + insetValue
                let calPoint = rect.midY - (tailSize.width / 2) + length
                
                startPoint = CGPoint(x: rect.maxX - insetValue,
                                     y: max(maxPoint, calPoint))
            }
        default:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.midY - (tailSize.width / 2))
        }
        
        print("startPoint : \(startPoint)")
        return startPoint
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipTrailingPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .custom, .top, .bottom:
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.minY + cornerRadius + insetValue)
        }
        
        print("startPoint : \(startPoint)")
        return startPoint
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading, .center, .trailing, .custom, .top, .bottom:
            print("leading")
            startPoint = CGPoint(x: rect.maxX - insetValue,
                                 y: rect.minY + insetValue)
        }
        
        print("startPoint : \(startPoint)")
        return startPoint
    }
}
