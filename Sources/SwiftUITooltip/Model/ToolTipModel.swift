//
//  ToolTipModel.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

/// 삼각형의 위치
@frozen
public enum TailPosition: Equatable {
    /// 상
    case top
    /// 좌
    case leading
    /// 우
    case trailing
    /// 하
    case bottom
}

/// ToolTip의 fill, stroke, strokeBorder의 옵션 style
@frozen
public enum ToolTipShapeStyle: Equatable {
    /// fill
    case fill
    /// stroke
    case stroke
    /// strokeBorder
    case strokeBorder
    /// fill & stroke
    case fillWithStroke
    /// fill & strokeBorder
    case fillWithStrokeBorder
}

/// ToolTip Tail의 Alignment 방식
@frozen
public enum TailAlignment: Equatable {
    /// 왼쪽
    case leading
    /// 중앙
    case center
    /// 오른쪽
    case trailing
    /// 상단
    case top
    /// 하단
    case bottom
}

/// ToolTip의 Layout Mode
///
/// flexible을 설정할 경우, tailSize가 부모 size보다 오버할 경우, 유연하게 잡아주도록 한다.
@frozen
public enum ToolTipLayoutMode: Equatable {
    /// 고정 사이즈
    case fixed
    /// 유동 사이즈
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
    
    /// 삼각형의 alignment
    public var tailAlignment: TailAlignment
    
    /// 삼각형의 alignment에서 이동할 좌표 값
    public var movePoint: CGFloat = .zero
    
    /// View의 cornerRadius
    public var cornerRadius: CGFloat
    
    /// style의 fill이 들어간 옵션일 때, 적용되는 Color
    public var fillColor: Color
    
    /// style의 stroke이 들어간 옵션일 때, 적용되는 Color
    public var strokeColor: Color
    
    /// StrokeStyle옵션
    public var strokeStyle: StrokeStyle
    
    /// 삼각형을 그릴 수 있는 지 아닌지 옵션
    var canDrawTail: Bool = true
    
    /// cornerRadius가 strokeStyle의 lineWidth의 절반 이하일 경우의 옵션
    var limitBaseLine: Bool = false
    
    public init(style: ToolTipShapeStyle,
                mode: ToolTipLayoutMode = .fixed,
                tailSize: CGSize = .zero,
                tailPosition: TailPosition = .top,
                tailAlignment: TailAlignment = .center,
                movePoint: CGFloat = .zero,
                cornerRadius: CGFloat = .zero,
                fillColor: Color = .white,
                strokeColor: Color = .white,
                strokeStyle: StrokeStyle = StrokeStyle()) {
        self.style = style
        self.mode = mode
        self.tailSize = tailSize
        self.tailPosition = tailPosition
        self.tailAlignment = tailAlignment
        self.movePoint = movePoint
        self.cornerRadius = cornerRadius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.strokeStyle = strokeStyle
    }
}

public extension ToolTipModel {
    /// ToolTipModel의 style이 strokeBorder인지 파악하는 변수
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
