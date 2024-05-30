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
}

// MARK: Fixed Mode Start Point
extension ToolTipBottomPath {
    func getStartPointToFixed(in rect: CGRect) -> CGPoint {
        return .zero
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipBottomPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipBottomPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
}
