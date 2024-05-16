# SwiftUITooltip


### Requirements
* iOS 13.0+
* Xcode 11.0+
* Swift 5.1


### Content
* [Documentation](#documentation)
  * [ToolTip Modifier](#toolTip_modifier)
 


<a name="documentation"></a>
# Documentation

SwiftUI에서 ToolTip을 그릴려면 tail의 position이 해당 View의 rect의 x,y 값에서 어느정도 이동을 해야하며   
곡선을 그리는 계산, 그리고 border나 fill을 채우는 방식등을 직접 구현하려면 복잡합니다.   
해당 SwiftUIToolTip은 그것을 간편하게 그릴 수 있게 도와줍니다.


<a name="toolTip_modifier"></a>
## ToolTip Modifier


* **`func toolTip(style: ToolTipShapeStyle,
                            tailSize: CGSize = .zero,
                            tailPosition: TailPosition = .top,
                            movePoint: CGFloat = .zero,
                            cornerRadius: CGFloat = .zero,
                            fillColor: Color = .white,
                            strokeColor: Color = .white,
                            strokeStyle: StrokeStyle = StrokeStyle()) -> some View`**    

* **`func toolTip(_ model: @escaping () -> ToolTipModel) -> some View`**   
