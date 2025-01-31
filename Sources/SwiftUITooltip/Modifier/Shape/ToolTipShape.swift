//
//  ToolTipShape.swift
//  
//
//  Created by Gab on 2024/02/27.
//

import SwiftUI

struct ToolTipShape: Shape, InsettableShape {
    @Environment(\.layoutDirection) private var layoutDirection
    
    @ObservedObject var viewModel: ToolTipViewModel
    
    @State var provider: PathProvidingProtocol?
    
    var model: ToolTipModel
    
    var insetValue: CGFloat = 0
    
    init(model: ToolTipModel) {
        self.model = model
        viewModel = ToolTipViewModel(model: model)
        _provider = State(wrappedValue: getPathProviding())
    }
    
    func path(in rect: CGRect) -> Path {
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
    
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var tooltip = self
        tooltip.insetValue = amount
        return tooltip
    }
    
    func getPathProviding() -> PathProvidingProtocol {
        let insetValue: CGFloat = model.isStrokeBorder ? max(insetValue, viewModel(\.strokeStyle).lineWidth / 2) : .zero

        switch viewModel(\.tailPosition) {
        case .top:
            return ToolTipTopPath(viewModel: viewModel,
                                     insetValue: insetValue)
        case .leading:
            return ToolTipLeadingPath(viewModel: viewModel,
                                     insetValue: insetValue)
        case .trailing:
            return ToolTipTrailingPath(viewModel: viewModel,
                                     insetValue: insetValue)
        case .bottom:
            return ToolTipBottomPath(viewModel: viewModel,
                                     insetValue: insetValue)
        }
    }
}

private extension ToolTipShape {
    
    func tailTopPath(in rect: CGRect) -> Path {
        guard let provider else {
            return Path()
        }
        
        if model.mode == .fixed {
            
            return provider.fixedPath(in: rect)
            
        } else {
            
            provider.calCornerRadius(in: rect)
            return provider.flexiblePath(in: rect)
            
        }
    }
    
    func tailLeadingPath(in rect: CGRect) -> Path {
        guard let provider else {
            return Path()
        }
        
        if model.mode == .fixed {
            
            return provider.fixedPath(in: rect)
            
        } else {
            
            provider.calCornerRadius(in: rect)
            return provider.flexiblePath(in: rect)
            
        }
    }
    
    func tailTrailingPath(in rect: CGRect) -> Path {
        guard let provider else {
            return Path()
        }
        
        if model.mode == .fixed {
            
            return provider.fixedPath(in: rect)
            
        } else {
            
            provider.calCornerRadius(in: rect)
            return provider.flexiblePath(in: rect)
            
        }
    }
    
    func tailBottomPath(in rect: CGRect) -> Path {
        guard let provider else {
            return Path()
        }
        
        if model.mode == .fixed {
            
            return provider.fixedPath(in: rect)
            
        } else {
            
            provider.calCornerRadius(in: rect)
            return provider.flexiblePath(in: rect)
            
        }
    }
}
