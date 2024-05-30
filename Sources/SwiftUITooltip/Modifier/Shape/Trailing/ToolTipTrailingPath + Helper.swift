//
//  ToolTipTrailingPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

// MARK: calculate CornerRadius
extension ToolTipTrailingPath {
    func calCornerRadius(in rect: CGRect) {
        
    }
}

// MARK: Fixed Mode Start Point
extension ToolTipTrailingPath {
    func getStartPointToFixed(in rect: CGRect) -> CGPoint {
        return .zero
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipTrailingPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipTrailingPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
}
