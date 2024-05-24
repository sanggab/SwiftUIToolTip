//
//  TopPathHelper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/24.
//

import SwiftUI

extension ToolTipShape {
    
    func calFixedCenterPointToTop(in rect: CGRect) -> CGPoint {
        print("rect : \(rect)")
        var startPoint: CGPoint = .zero
        
        switch model.tailAlignment {
        case .leading:
            
            startPoint = CGPoint(x: rect.minX + model.cornerRadius + (model.tailSize.width / 2),
                                 y: rect.minY + insetValue)
           
            return startPoint
        case .center:
            startPoint = CGPoint(x: rect.midX,
                                 y: rect.minY + insetValue)
            
            return startPoint
        case .trailing:
            
            startPoint = CGPoint(x: rect.maxX - model.cornerRadius - (model.tailSize.width / 2),
                                 y: rect.minY + insetValue)
                
            return startPoint
        case .custom(let length):
            
            startPoint = CGPoint(x: rect.midX + length,
                                 y: rect.minY + insetValue)
            
            return startPoint
        }
    }
    
    
    func calFlexibleStartPointPositionTop(in rect: CGRect) -> CGPoint {
        print(#function)
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("Leading")
            startPoint = CGPoint(x: rect.minX + viewModel(\.cornerRadius),
                                 y: rect.minY + insetValue)
            
            print("startPoint : \(startPoint)")
            
            return startPoint
        case .trailing:
            print("Trailing")
            let maxX = rect.maxX - viewModel(\.cornerRadius)
            let startX = maxX - viewModel(\.tailSize).width
            print("maxX : \(maxX)")
            print("startX : \(startX)")
            
            startPoint = CGPoint(x: startX,
                                  y: rect.minY + insetValue)
            
            print("startPoint : \(startPoint)")
            return startPoint
        case .center:
            print("Center")
            startPoint = CGPoint(x: rect.midX - (viewModel(\.tailSize).width / 2),
                                 y: rect.minY + insetValue)
            
            print("startPoint : \(startPoint)")
            return startPoint
        case .custom(let length):
            print("Custom : \(length)")
            
            if length >= 0 {
                print("center에서 오른쪽으로 이동")
                let maxX = rect.maxX - viewModel(\.cornerRadius)
                let pointX = rect.midX - (viewModel(\.tailSize.width) / 2)
                let baseLineX = pointX + length

                if (baseLineX + viewModel(\.tailSize).width) > maxX {
                    print("length가 maxX를 침범함")
                    startPoint = CGPoint(x: maxX - viewModel(\.tailSize).width ,
                                         y: rect.minY + insetValue)
                } else {
                    print("length가 maxX를 침범안함")
                    startPoint = CGPoint(x: baseLineX,
                                         y: rect.minY + insetValue)
                }
                
            } else {
                print("center에서 왼쪽으로 이동")
                var maxX = rect.minX + viewModel(\.cornerRadius)
                let pointX = rect.midX - (viewModel(\.tailSize.width) / 2)
                let baseLineX = pointX + length
                
                print("maxX : \(maxX)")
                print("pointX : \(pointX)")
                
                if baseLineX > maxX {
                    print("baseLineX가 maxX보다 큼")
                    startPoint = CGPoint(x: baseLineX,
                                         y: rect.minY + insetValue)
                } else {
                    print("baseLineX가 maxX보다 작음")
                    startPoint = CGPoint(x: maxX,
                                         y: rect.minY + insetValue)
                }
            }
            
            print("startPoint : \(startPoint)")
            return startPoint
        }
    }
    
    func calStartPointBaseLineOver(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("calStartPointBaseLineOver leading")
            
        case .center:
            print("calStartPointBaseLineOver center")
            
        case .trailing:
            print("calStartPointBaseLineOver trailing")
            
        case .custom(let length):
            print("calStartPointBaseLineOver custom length : \(length)")
        }
     
        print("calStartPointBaseLineOver startPoint : \(startPoint)")
        return startPoint
    }
    
    func calStartPointBaseLineNotOver(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("calStartPointBaseLineNotOver leading")
            
        case .center:
            print("calStartPointBaseLineNotOver center")
            
        case .trailing:
            print("calStartPointBaseLineNotOver trailing")
            
        case .custom(let length):
            print("calStartPointBaseLineNotOver custom length : \(length)")
        }
     
        print("calStartPointBaseLineNotOver startPoint : \(startPoint)")
        return startPoint
    }
}

extension ToolTipShape {
    
    func calLimitBaseLineStratPoint(in rect: CGRect) -> CGPoint {
        let cornerRadius: CGFloat = viewModel(\.cornerRadius)
        
        var startPoint: CGPoint = .zero
        
        switch viewModel(\.tailAlignment) {
        case .leading:
            print("calLimitBaseLineStratPoint leading")
            startPoint = CGPoint(x: rect.minX + insetValue,
                                 y: rect.minY + insetValue)
            
        case .center:
            print("calLimitBaseLineStratPoint center")
            
        case .trailing:
            print("calLimitBaseLineStratPoint trailing")
            
        case .custom(let length):
            print("calLimitBaseLineStratPoint custom length : \(length)")
        }
     
        print("calLimitBaseLineStratPoint startPoint : \(startPoint)")
        return startPoint
    }
}
