//
//  SwiftUIView.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public struct ToolTipModifier: ViewModifier {
    public var model: ToolTipModel
    
    public init(model: ToolTipModel) {
        self.model = model
    }
    
    public func body(content: Content) -> some View {
        let style = model.style
        
        content
            .overlay {
                if style == .stroke || style == .fillWithStroke {
                    ToolTipShape(radius: model.cornerRadius,
                                 tailSize: model.tailSize,
                                 tailPosition: model.tailPosition,
                                 movePoint: model.movePoint)
                    .stroke(model.strokeColor, style: model.strokeStyle)
                } else if style == .strokeBorder || style == .fillWithStrokeBorder {
                    ToolTipShape(radius: model.cornerRadius,
                                 tailSize: model.tailSize,
                                 tailPosition: model.tailPosition,
                                 movePoint: model.movePoint)
                    .strokeBorder(model.strokeColor, style: model.strokeStyle)
                } else {
                    EmptyView()
                }
            }
            .background {
                if style == .fill || style == .fillWithStroke {
                    ToolTipShape(radius: model.cornerRadius,
                                 tailSize: model.tailSize,
                                 tailPosition: model.tailPosition,
                                 movePoint: model.movePoint)
                    .fill(model.fillColor)
                } else if style == .fillWithStrokeBorder {
                    ToolTipShape(radius: model.cornerRadius,
                                 tailSize: model.tailSize,
                                 tailPosition: model.tailPosition,
                                 movePoint: model.movePoint)
                    .inset(by: model.strokeStyle.lineWidth / 2)
                    .fill(model.fillColor)
                } else {
                    EmptyView()
                }
            }
    }
}
