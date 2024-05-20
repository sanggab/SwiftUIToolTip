//
//  ToolTipModel.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

/// 삼각형의 위치 - 상, 하, 좌, 우
@frozen
public enum TailPosition: Equatable {
    case top
    
    case leading
    
    case trailing
    
    case bottom
}

/// ToolTip의 fill, stroke, strokeBorder의 옵션 style
@frozen
public enum ToolTipShapeStyle: Equatable {
    case fill
    
    case stroke
    
    case strokeBorder
    
    case fillWithStroke
    
    case fillWithStrokeBorder
}

/// ToolTip을 구성하기 위해 필요한 모델
@frozen
public struct ToolTipModel: Equatable {
    
    /// ToolTip의 fill, stroke, strokeBorder의 옵션 style
    public var style: ToolTipShapeStyle
    
    /// 삼각형의 사이즈
    public var tailSize: CGSize
    
    /// 삼각형의 위치 - 상/하/좌/우
    public var tailPosition: TailPosition
    
    /// center에서 x,y좌표를 기준으로 얼만큼 움직일것인가
    public var movePoint: CGFloat
    
    /// View의 cornerRadius
    public var cornerRadius: CGFloat
    
    /// style의 fill이 들어간 옵션일 때, 적용되는 Color
    public var fillColor: Color
    
    /// style의 stroke이 들어간 옵션일 때, 적용되는 Color
    public var strokeColor: Color
    
    /// StrokeStyle옵션
    public var strokeStyle: StrokeStyle
    
    public init(style: ToolTipShapeStyle,
                tailSize: CGSize = .zero,
                tailPosition: TailPosition = .top,
                movePoint: CGFloat = .zero,
                cornerRadius: CGFloat = .zero,
                fillColor: Color = .white,
                strokeColor: Color = .white,
                strokeStyle: StrokeStyle = StrokeStyle()) {
        self.style = style
        self.tailSize = tailSize
        self.tailPosition = tailPosition
        self.movePoint = movePoint
        self.cornerRadius = cornerRadius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.strokeStyle = strokeStyle
    }
}

