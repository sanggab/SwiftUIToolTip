//
//  ToolTipShape.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public struct ToolTipShape: Shape, InsettableShape {
    @Environment(\.layoutDirection) private var layoutDirection
    
    public var model: ToolTipModel
    
    @ObservedObject var viewModel: ToolTipViewModel
    
    public init(model: ToolTipModel) {
        self.model = model
        viewModel = ToolTipViewModel(model: model)
    }
    
    public var insetValue: CGFloat = 0
    
    public func path(in rect: CGRect) -> Path {
        switch model.tailPosition {
        case .top:
            return tailTopPath(in: rect)
        case .leading:
            if layoutDirection == .leftToRight {
                return tailLeadingPath(in: rect)
            } else {
                return tailTrailingPath(in: rect)
            }
        case .trailing:
            if layoutDirection == .leftToRight {
                return tailTrailingPath(in: rect)
            } else {
                return tailLeadingPath(in: rect)
            }
        case .bottom:
            return tailBottomPath(in: rect)
        }
    }
    
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var tooltip = self
        tooltip.insetValue = amount
        return tooltip
    }
    
    public func calCornerRadius(in rect: CGRect) {
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
        
        switch viewModel(\.tailPosition) {
        case .leading, .trailing:
            print("ih")
            if tailSize.width + hypotenuse > rect.height {
                print("해당 height에 tail을 그릴 순 없으니 그냥 cornerRadius만 갱신시켜보자")
                viewModel.update(\.canDrawTail, false)
                var calHalfMin = min(halfWidth, halfHeight)
                calHalfMin = min(calHalfMin, cornerRadius)
                viewModel.update(\.cornerRadius, calHalfMin)
            } else {
                let drawBaseLine = viewModel(\.tailSize.width) + (cornerRadius * 2)
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
            
        case .top, .bottom:
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
        }
        
        // MARK: - strokeBorder에서 lineJoin이 miter이면서 cornerRadius가 insetValue보다 작거나 같은 경우, cornerRadius는 적용되지 않는다.
        if style == .strokeBorder || style == .fillWithStrokeBorder,  insetValue >= cornerRadius {
            print("cornerRadius 0으로 만든다")
            viewModel.update(\.cornerRadius, 0)
            viewModel.update(\.limitBaseLine, true)
        }
        
        print("계산끝난 cornerRadius : \(viewModel(\.cornerRadius))")
        
    }
    
    
    func calculateHypotenuse(base: CGFloat, height: CGFloat) -> CGFloat {
        return sqrt(pow(base, 2) + pow(height, 2))
    }

}

private extension ToolTipShape {
    
    func tailTopPath(in rect: CGRect) -> Path {
        model.mode == .fixed ? fixedTopPath(in: rect) : flexibleTopPath(in: rect)
    }
    
    func tailLeadingPath(in rect: CGRect) -> Path {
        model.mode == .fixed ? fixedLeadingPath(in: rect) : flexibleLeadingPath(in: rect)
    }
    
    func tailTrailingPath(in rect: CGRect) -> Path {
        model.mode == .fixed ? fixedTrailingPath(in: rect) : flexibleTrailingPath(in: rect)
    }
    
    func tailBottomPath(in rect: CGRect) -> Path {
        model.mode == .fixed ? fixedBottomPath(in: rect) : flexibleBottomPath(in: rect)
    }
}
