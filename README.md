# SwiftUITooltip

SwiftUI에서 ToolTipBox를 간단하게 그려보자

Text("\"Liked your Photo\"")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.text)
                        .lineLimit(1)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 5)
                        .toolTip(style: .fillWithStrokeBorder,
                                 tailSize: CGSize(width: 20, height: 14),
                                 cornerRadius: 12,
                                 fillColor: .white238,
                                 strokeColor: .white,
                                 strokeStyle: StrokeStyle(lineWidth: 2,
                                                          lineCap: .round,
                                                          lineJoin: .round))
