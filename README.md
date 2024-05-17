# SwiftUITooltip


### Requirements
* iOS 13.0+
* Xcode 11.0+
* Swift 5.1


### Content
* [Documentation](#documentation)
  * [ToolTip Modifier](#toolTip_modifier)
  * [주의점](#attention)
  * [Method](#method)
 


<a name="documentation"></a>
# Documentation

SwiftUI에서 ToolTip을 그릴려면 tail의 position이 해당 View의 rect의 x,y 값에서 어느정도 이동을 해야하며   
곡선을 그리는 계산, 그리고 border나 fill을 채우는 방식등을 직접 구현하려면 복잡합니다.   
해당 SwiftUIToolTip은 그것을 간편하게 그릴 수 있게 도와줍니다.


<a name="toolTip_modifier"></a>
## ToolTip Modifier

##### ToolTipModel
| Value | Description | Default |
|:---------------------:|:------------------:|:---------:|
| **style** | ToolTip의 fill, stroke, strokeBorder style을 정한다. | 필수 |
| **tailSize** | ToolTip의 삼각형의 Size | zero |
| **tailPosition** | ToolTip의 삼각형의 위치 - 상/하/좌/우 | top |
| **movePoint** | ToolTip이 삼각형이 position의 center의 위치에서 x,y좌표를 기준으로 해당 값 만큼 움직일지 정한다. | zero(center) |
| **cornerRadius** | View의 CornerRadius | zero |
| **fillColor** | style이 fill일 때 적용되는 옵션 - Color를 바꾼다. | white |
| **strokeColor** | style이 stroke거나 strokeBorder일 때 적용되는 옵션 - Color를 바꾼다. | white |
| **strokeStyle** | Shape의 StrokeyStyle 옵션 | StrokeyStyle() |


<a name="attention"></a>
### 주의점

ToolTipModel의 style에 따라 적용되는게 있을 수 있고 아닐 수 있습니다.   
기본적으로 모든 style들은 tailSize, tailPosition, movePoint, cornerRadius를 다 적용받습니다.
하지만 fillColor, strokeColor, strokeStyle은 style에 따라 다를 수 있습니다.

| style | fillColor | strokeColor | strokeStyle |
|:---------------------:|:-------:|:-------:|:-------:|
| **fill** | O | X | X |
| **stroke** | X | O | O |
| **strokeBorder** | X | O | O |
| **fillWithStroke** | O | O | O |
| **fillWithStrokeBorder** | O | O | O |

그리고 기본적으로 Shape의 특성을 그대로 사용하기 때문에 border을 적용시킬 때, stroke와 strokeBorder의 차이점을 유의하셔야 합니다.


<br>

<a name="Method"></a>
### Method

* **`func toolTip(style: ToolTipShapeStyle,
                     tailSize: CGSize = .zero,
                     tailPosition: TailPosition = .top,
                     movePoint: CGFloat = .zero,
                     cornerRadius: CGFloat = .zero,
                     fillColor: Color = .white,
                     strokeColor: Color = .white,
                     strokeStyle: StrokeStyle = StrokeStyle()) -> some View`**


   설정한 parameters에 따라 toolTip을 그립니다.



   ##### Usage examples:

  ```
  Text("나는 문어 대왕 문어")
      .padding(.all, 8)
      .toolTip(style: .fillWithStroke,
               tailSize: CGSize(width: 20, height: 14),
               tailPosition: .top,
               movePoint: 0,
               cornerRadius: 6,
               fillColor: .white,
               strokeColor: .blue,
               strokeStyle: StrokeStyle(lineWidth: 2,
                                        lineCap: .round,
                                        lineJoin: .round))
  ```
* **`func toolTip(_ model: @escaping () -> ToolTipModel) -> some View`**

   closure에 구현한 model을 이용해 toolTip을 그립니다.

   ###### Usage examples:

  ```
  Text("나는 문어 대왕 문어")
      .padding(.all, 8)
      .toolTip {
          ToolTipModel(style: .strokeBorder,
                       tailSize: CGSize(width: 20, height: 14),
                       tailPosition: .bottom,
                       movePoint: 30,
                       cornerRadius: 10,
                       strokeColor: .orange,
                       strokeStyle: StrokeStyle(lineWidth: 2,
                                                lineCap: .round,
                                                lineJoin: .round))
      }
  ```

