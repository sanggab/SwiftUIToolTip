//
//  ToolTipTopPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

extension ToolTipTopPath {
    
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
        
        if tailSize.width + hypotenuse > rect.width {
            print("해당 width에 tail을 그릴 순 없으니 그냥 cornerRadius만 갱신시켜보자")
            viewModel.update(\.canDrawTail, false)
            var calHalfMin = min(halfWidth, halfHeight)
            calHalfMin = min(calHalfMin, cornerRadius)
            viewModel.update(\.cornerRadius, calHalfMin)
        } else {
            let drawBaseLine = tailSize.width + (cornerRadius * 2)
            print("drawBaseLine : \(drawBaseLine)")
            
            if drawBaseLine > rect.width {
                print("현재 입력한 데이터로는 이상하다 cornerRadius 재정의")
                viewModel.update(\.canDrawTail, true)
                var calHalfMin = min(halfWidth, halfHeight)
                calHalfMin = min(calHalfMin, cornerRadius)
                calHalfMin = min(calHalfMin, cornerRadius - (drawBaseLine - rect.width) / 2)
                
                viewModel.update(\.cornerRadius, calHalfMin)
            } else {
                print("음음 그냥 통과인 것 같지만 cornerRadius가 halfHeight하고 비교해서 재정립 해야한다.")
                viewModel.update(\.canDrawTail, true)
                viewModel.update(\.cornerRadius, min(viewModel(\.cornerRadius), halfHeight))
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
    
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("center")
            
        case .trailing:
            print("trailing")
            
        case .custom(let length):
            print("custom length : \(length)")
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
        case .center:
            print("center")
            
        case .trailing:
            print("trailing")
            
        case .custom(let length):
            print("custom length : \(length)")
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
}

extension ToolTipTopPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        let tailSize: CGSize = viewModel(\.tailSize)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + cornerRadius + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("center")
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
            
        case .trailing:
            print("trailing")
            startPoint = CGPoint(x: rect.maxX - cornerRadius - tailSize.width - insetValue,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            print("custom length : \(length)")
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
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        let tailSize: CGSize = viewModel(\.tailSize)
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("leading")
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("center")
            startPoint = CGPoint(x: rect.midX - (tailSize.width / 2),
                                 y: rect.minY + insetValue)
            
        case .trailing:
            print("trailing")
            
            startPoint = CGPoint(x: rect.maxX - tailSize.width - insetValue,
                                 y: rect.minY + insetValue)
            
        case .custom(let length):
            print("custom length : \(length)")
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
        }
     
        print("startPoint : \(startPoint)")
        return startPoint
    }
}
