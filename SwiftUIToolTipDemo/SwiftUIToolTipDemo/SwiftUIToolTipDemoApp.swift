//
//  SwiftUIToolTipDemoApp.swift
//  SwiftUIToolTipDemo
//
//  Created by Gab on 2024/05/21.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct SwiftUIToolTipDemoApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
                ContentView()
            } else {
                // Fallback on earlier versions
                EmptyView()
            }
        }
    }
}
