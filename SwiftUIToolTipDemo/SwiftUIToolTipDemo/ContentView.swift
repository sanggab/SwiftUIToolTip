//
//  ContentView.swift
//  SwiftUIToolTipDemo
//
//  Created by Gab on 2024/05/21.
//

import SwiftUI
import SwiftUIToolTip

struct ContentView: View {
    var body: some View {
        Text("100ss")
            .frame(height: 18)
//            .padding()
//            .background(Color.gray, alignment: .center)
//            .cornerRadius(5)
//            .cornerRadius(5)
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(style: StrokeStyle(lineWidth: 2, lineCap: .round)), alignment: .center)
            .toolTip {
                ToolTipModel(style: .strokeBorder,
                             mode: .flexible,
                             tailSize: CGSize(width: 20, height: 20),
                             tailPosition: .leading,
                             tailAlignment: .trailing,
                             cornerRadius: 10,
                             fillColor: .blue,
                             strokeColor: .pink.opacity(0.8),
                             strokeStyle: StrokeStyle(lineWidth: 2,
                                                      lineCap: .round,
                                                      lineJoin: .round))
            }
    }
}

#Preview {
    ContentView()
}
