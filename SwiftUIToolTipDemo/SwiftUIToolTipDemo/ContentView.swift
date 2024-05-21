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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .toolTip(style: .fillWithStrokeBorder,
                 tailSize: CGSize(width: 20, height: 14),
                 tailPosition: .top,
                 movePoint: .zero,
                 cornerRadius: 10,
                 fillColor: .pink,
                 strokeColor: .mint,
                 strokeStyle: StrokeStyle(lineWidth: 4,
                                          lineCap: .round,
                                          lineJoin: .round))
    }
}

#Preview {
    ContentView()
}
