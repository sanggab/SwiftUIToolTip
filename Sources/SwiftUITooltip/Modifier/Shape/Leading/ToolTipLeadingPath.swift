//
//  ToolTipLeadingPath.swift
//  SwiftUIToolTip
//
//  Created by Gab on 2024/05/30.
//

import SwiftUI

struct ToolTipLeadingPath: PathFeatures {
    @ObservedObject var viewModel: ToolTipViewModel
    var insetValue: CGFloat
    
    init(viewModel: ToolTipViewModel,
         insetValue: CGFloat) {
        self.viewModel = viewModel
        self.insetValue = insetValue
    }
}

// MARK: Decide Path
extension ToolTipLeadingPath {
    func fixedPath(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func flexiblePath(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func getPathToTailSizeNotOver(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func getPathToTailSizeOver(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}

// MARK: TailSize Not Over Path
extension ToolTipLeadingPath {
    func tailSizeNotOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func tailSizeNotOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}

// MARK: TailSize Over Path
extension ToolTipLeadingPath {
    func tailSizeOverBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
    
    func tailSizeOverLimitBaseLine(in rect: CGRect) -> Path {
        print(#function)
        return Path { path in
            
        }
    }
}
