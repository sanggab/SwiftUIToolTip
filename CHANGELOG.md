# CHANGELOG

-----

## [1.3.0 - The movePoint has been resurrected](https://github.com/sanggab/SwiftUIToolTip/releases/tag/1.3.0) (2025-01-31)
* 1.2.0 버전에서 사라진 `movePoint`가 새롭게 돌아왔습니다!  
* `tailPosition` 과 `tailAlignment`에 의해 배치된 삼각형이 해당 위치에서 x,y 좌표 기준으로 추가로 이동할 거리를 지정할 수 있습니다.
* `ToolTipLayoutMode` 모드에서 `flexible`를 선택한 경우, `movePoint`를 배치할 수 있는 좌표까지 최대한 배치합니다.

---

## [1.2.0 - Added New ToolTipModel Option, Added handling for cases when using strokeBorder](https://github.com/sanggab/SwiftUIToolTip/releases/tag/1.2.0) (2024-06-04)
* 기존 ToolTipModel의 옵션 중 `movePoint`가 사라지고 새로운 옵션인 `mode`, `tailAlignment`가 추가되었습니다.
* `mode`는 내가 입력한 model대로 그려지게 하는 `fixed` 모드, 내가 입력한 model이 rect가 오버해서 이상하게 그려질 경우를 유연하게 잡아주는 `flexible` 옵션을 제공해줍니다.

* `tailAlignment`는 tailPosition에 의해 배치된 삼각형이 해당 위치에서 top, leading, trailing, bottom, center, custom하게 이동시킬지 결정해주는 옵션입니다

* strokeBorder가 들어간 옵션일 떄, StrokeStyle의 lineJoin이 miter일 경우에 cornerRadius하고 lineWidth의 관계를 추가했습니다.

---

## [1.1.0 - folder structure improvement](https://github.com/sanggab/SwiftUIToolTip/releases/tag/1.1.0) (2024-05-21)
* Kingfisher와 FlexLayout의 구조를 보고 project와 workspace등을 추가해서 구조를 변경했습니다.   
* workspace에서 SwiftUIToolTipDemo에 SwiftUIToolTip framework를 추가해놔서 작업이 가능하게 세팅을 했습니다.

---

## [1.0.0 - SwiftUIToolTip, take off](https://github.com/sanggab/SwiftUIToolTip/releases/tag/1.0.0) (2024-05-17)
* First public release.
