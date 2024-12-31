//
//  ViewExtension.swift
//
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public extension View {
    
    /// ToolTip Modifier
    ///
    /// ToolTip을 구성하기 위해 필요한 정보들을 입력하면 만들어준다.
    ///
    /// - Parameters:
    ///     - style: ToolTip의 fill, stroke, strokeBorder의 옵션 style
    ///     - tailSize: 삼각형의 사이즈
    ///     - tailPosition: 삼각형의 위치 - 상/하/좌/우
    ///     - movePoint: center에서 x,y좌표를 기준으로 얼만큼 움직일것인가
    ///     - cornerRadius: View의 cornerRadius
    ///     - fillColor: style의 fill이 들어간 옵션일 때, 적용되는 Color
    ///     - strokeColor: style의 stroke이 들어간 옵션일 때, 적용되는 Color
    ///     - strokeStyle: StrokeStyle옵션
    @inlinable func toolTip(style: ToolTipShapeStyle,
                            mode: ToolTipLayoutMode = .fixed,
                            tailSize: CGSize = .zero,
                            tailPosition: TailPosition = .top,
                            tailAlignment: TailAlignment = .center,
                            movePoint: CGFloat = .zero,
                            cornerRadius: CGFloat = .zero,
                            fillColor: Color = .white,
                            strokeColor: Color = .white,
                            strokeStyle: StrokeStyle = StrokeStyle()) -> some View {
        modifier(ToolTipModifier(model: ToolTipModel(style: style,
                                                     mode: mode,
                                                     tailSize: tailSize,
                                                     tailPosition: tailPosition,
                                                     tailAlignment: tailAlignment,
                                                     cornerRadius: cornerRadius,
                                                     fillColor: fillColor,
                                                     strokeColor: strokeColor,
                                                     strokeStyle: strokeStyle)))
    }
    
    /// ToolTip Modifier
    ///
    /// ToolTipModel을 이용해서 ToolTip을 만든다.
    ///
    /// - Parameters:
    ///     - ToolTipModel: ToolTip을 구성하기 위해 필요한 모델
    @inlinable func toolTip(_ model: @escaping () -> ToolTipModel) -> some View {
        modifier(ToolTipModifier(model: model()))
    }
}
