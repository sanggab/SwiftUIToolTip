//
//  ToolTipProtocol.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

protocol PathProvidingProtocol {
    func fixedPath(in rect: CGRect) -> Path
    func flexiblePath(in rect: CGRect) -> Path
}

protocol PathCalStartPointProtocol {
    func getStartPointToSizeOverBaseLine(in rect: CGRect) -> CGPoint
    func getStartPointToSizeOverLimitBaseLine(in rect: CGRect) -> CGPoint
    func getStartPointToBaseLine(in rect: CGRect) -> CGPoint
    func getStartPointToLimitBaseLine(in rect: CGRect) -> CGPoint
}

protocol PathTailSizeOverProtocol {
    func getPathToTailSizeOver(in rect: CGRect) -> Path
    func tailSizeOverBaseLine(in rect: CGRect) -> Path
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path
}

protocol PathTailSizeNotOverProtocol {
    func getPathToTailSizeNotOver(in rect: CGRect) -> Path
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path
}

protocol PathFeatures: PathProvidingProtocol, PathCalStartPointProtocol, PathTailSizeOverProtocol, PathTailSizeNotOverProtocol {}
