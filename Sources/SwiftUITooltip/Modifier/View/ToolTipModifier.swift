//
//  ToolTipModifier.swift
//
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

public struct ToolTipModifier: ViewModifier {
    public var model: ToolTipModel
    
    @State private var calStrokeStyle: StrokeStyle = .init()
    @State private var size: CGSize = .zero
    
    public init(model: ToolTipModel) {
        self.model = model
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if model.style == .strokeBorder || model.style == .fillWithStrokeBorder, model.strokeStyle.lineWidth / 2 >= model.cornerRadius {
                    var newStyle = model.strokeStyle
                    newStyle.lineCap = .butt
                    newStyle.lineJoin = .miter
                    calStrokeStyle = newStyle
                }
            }
            .background(GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size = proxy.size
                    }
            })
            .overlay(overlayShapeView)
            .background(backgroundShapeView)
            .onChange(of: size) { newValue in
                var strokeStyle = model.strokeStyle
                let style = model.style
                
                if style == .strokeBorder || style == .fillWithStrokeBorder {
                    let halfWidth: CGFloat = newValue.width / 2
                    let halfHeight: CGFloat = newValue.height / 2
                    
                    if (strokeStyle.lineWidth / 2) > min(halfWidth, halfHeight) {
                        calStrokeStyle.lineWidth = 0
                    }
                }
            }
    }
    
    @ViewBuilder
    private var overlayShapeView: some View {
        let style = model.style
        
        if style == .stroke || style == .fillWithStroke {
            ToolTipShape(model: model)
                .stroke(model.strokeColor, style: calStrokeStyle)
        } else if style == .strokeBorder || style == .fillWithStrokeBorder {
            ToolTipShape(model: model)
                .strokeBorder(model.strokeColor, style: calStrokeStyle)
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
