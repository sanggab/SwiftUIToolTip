//
//  SwiftUIView.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public extension View {
    
    @inlinable func toolTip(style: ToolTipShapeStyle,
                            tailSize: CGSize = .zero,
                            tailPosition: TailPosition = .top,
                            movePoint: CGFloat = .zero,
                            cornerRadius: CGFloat = .zero,
                            fillColor: Color = .white,
                            strokeColor: Color = .white,
                            strokeStyle: StrokeStyle = StrokeStyle()) -> some View {
        modifier(ToolTipModifier(model: ToolTipModel(style: style,
                                                         tailSize: tailSize,
                                                         tailPosition: tailPosition,
                                                         movePoint: movePoint,
                                                         cornerRadius: cornerRadius,
                                                         fillColor: fillColor,
                                                         strokeColor: strokeColor,
                                                         strokeStyle: strokeStyle)))
    }
    
    @inlinable func toolTip(_ model: @escaping () -> ToolTipModel) -> some View {
        modifier(ToolTipModifier(model: model()))
    }
}
