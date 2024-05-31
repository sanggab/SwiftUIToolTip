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

@frozen
public enum TailAlignment: Equatable {
    case leading
    
    case center
    
    case trailing
    
    case top
    
    case bottom
    
    case custom(CGFloat)
}

/// ToolTip의 Layout Mode
///
/// flexible을 설정할 경우, tailSize가 부모 size보다 오버할 경우, 유연하게 잡아주도록 한다.
@frozen
public enum ToolTipLayoutMode: Equatable {
    case fixed
    
    case flexible
}

/// ToolTip을 구성하기 위해 필요한 모델
@frozen
public struct ToolTipModel: Equatable {
    
    /// ToolTip의 fill, stroke, strokeBorder의 옵션 style
    public var style: ToolTipShapeStyle
    
    /// ToolTip의 LayoutMode
    public var mode: ToolTipLayoutMode
    
    /// 삼각형의 사이즈
    public var tailSize: CGSize
    
    /// 삼각형의 위치 - 상/하/좌/우
    public var tailPosition: TailPosition
    
    
    public var tailAlignment: TailAlignment
    
    /// View의 cornerRadius
    public var cornerRadius: CGFloat
    
    /// style의 fill이 들어간 옵션일 때, 적용되는 Color
    public var fillColor: Color
    
    /// style의 stroke이 들어간 옵션일 때, 적용되는 Color
    public var strokeColor: Color
    
    /// StrokeStyle옵션
    public var strokeStyle: StrokeStyle
    
    var canDrawTail: Bool = true
    
    var limitBaseLine: Bool = false
    
    public init(style: ToolTipShapeStyle,
                mode: ToolTipLayoutMode = .fixed,
                tailSize: CGSize = .zero,
                tailPosition: TailPosition = .top,
                tailAlignment: TailAlignment = .center,
                cornerRadius: CGFloat = .zero,
                fillColor: Color = .white,
                strokeColor: Color = .white,
                strokeStyle: StrokeStyle = StrokeStyle()) {
        self.style = style
        self.mode = mode
        self.tailSize = tailSize
        self.tailPosition = tailPosition
        self.tailAlignment = tailAlignment
        self.cornerRadius = cornerRadius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.strokeStyle = strokeStyle
    }
}

public extension ToolTipModel {
    var isStrokeBorder: Bool {
        switch self.style {
        case .fill:
            return false
        case .stroke:
            return false
        case .strokeBorder:
            return true
        case .fillWithStroke:
            return false
        case .fillWithStrokeBorder:
            return true
        }
    }
}
