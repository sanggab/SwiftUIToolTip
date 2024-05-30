//
//  ToolTipLeadingPath + Helper.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

// MARK: calculate CornerRadius
extension ToolTipLeadingPath {
    func calCornerRadius(in rect: CGRect) {
        
    }
}

// MARK: TailSize Not Over StartPoint
extension ToolTipLeadingPath {
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
    
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
}

// MARK: TailSize Over StartPoint
extension ToolTipLeadingPath {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
    
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint {
        return .zero
    }
}
