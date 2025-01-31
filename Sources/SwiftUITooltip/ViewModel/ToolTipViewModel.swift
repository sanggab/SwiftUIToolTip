//
//  ToolTipViewModel.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/22.
//

import SwiftUI

class ToolTipViewModel: ObservableObject {
    @Published private var model: ToolTipModel = .init(style: .fill)
    
    init(model: ToolTipModel) {
        self.model = model
    }
    
    func callAsFunction<V: Equatable>(_ keyPath: KeyPath<ToolTipModel, V>) -> V {
        return model[keyPath: keyPath]
    }
    
    func update<V: Equatable>(_ keyPath: WritableKeyPath<ToolTipModel, V>, _ newValue: V) {
        model[keyPath: keyPath] = newValue
    }
}
