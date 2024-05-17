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
        content
            .overlay(overlayShapeView)
            .background(backgroundShapeView)
    }
    
    @ViewBuilder
    private var overlayShapeView: some View {
        let style = model.style
        
        if style == .stroke || style == .fillWithStroke {
            ToolTipShape(model: model)
                .stroke(model.strokeColor, style: model.strokeStyle)
        } else if style == .strokeBorder || style == .fillWithStrokeBorder {
            ToolTipShape(model: model)
                .strokeBorder(model.strokeColor, style: model.strokeStyle)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var backgroundShapeView: some View {
        let style = model.style
        
        if style == .fill || style == .fillWithStroke {
            ToolTipShape(model: model)
                .fill(model.fillColor)
        } else if style == .fillWithStrokeBorder {
            ToolTipShape(model: model)
                .inset(by: model.strokeStyle.lineWidth / 2)
                .fill(model.fillColor)
        } else {
            EmptyView()
        }
    }

}
