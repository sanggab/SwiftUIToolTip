//
//  ContentView.swift
//  SwiftUIToolTipDemo
//
//  Created by Gab on 2024/05/21.
//

import SwiftUI
import SwiftUIToolTip

@available(iOS 15.0, *)
struct ContentView: View {
    var body: some View {
        Text("100sss")
//            .frame(height: 36)
//            .padding()
//            .background(Color.gray, alignment: .center)
//            .cornerRadius(5)
//            .cornerRadius(5)
            .background {
                RoundedRectangle(cornerRadius: 10).strokeBorder(style: StrokeStyle(lineWidth: 3, lineCap: .round))
            }
            .toolTip {
                ToolTipModel(style: .strokeBorder,
                             mode: .flexible,
                             tailSize: CGSize(width: 24, height: 10),
                             tailPosition: .top,
                             tailAlignment: .leading,
                             cornerRadius: 10,
                             fillColor: .blue,
                             strokeColor: .pink.opacity(0.9),
                             strokeStyle: StrokeStyle(lineWidth: 3,
                                                      lineCap: .round,
                                                      lineJoin: .round))
            }
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        ContentView()
    } else {
        // Fallback on earlier versions
        EmptyView()
    }
}
