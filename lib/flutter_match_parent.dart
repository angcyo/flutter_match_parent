library flutter_match_parent;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///
/// 用最大的约束约束child
///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/08
///

/// [WrapContentLayout]
class MatchParentLayout extends SingleChildRenderObjectWidget {
  /// 对齐方式
  final AlignmentDirectional alignment;

  /// 是否撑满宽度
  final bool matchWidth;

  /// 是否撑满高度
  final bool matchHeight;

  const MatchParentLayout({
    super.key,
    super.child,
    this.matchWidth = true,
    this.matchHeight = true,
    this.alignment = AlignmentDirectional.center,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => MatchParentBox(
        alignment: alignment,
        matchHeight: matchHeight,
        matchWidth: matchWidth,
        textDirection: Directionality.of(context),
      );

  @override
  void updateRenderObject(BuildContext context, MatchParentBox renderObject) {
    renderObject
      ..alignment = alignment
      ..matchWidth = matchWidth
      ..matchHeight = matchHeight
      ..markNeedsLayout();
  }
}

/// [WrapContentBox]
class MatchParentBox extends RenderAligningShiftedBox {
  /// 是否撑满宽度
  bool matchWidth;

  /// 是否撑满高度
  bool matchHeight;

  MatchParentBox({
    super.alignment,
    super.textDirection,
    this.matchWidth = true,
    this.matchHeight = true,
  });

  /// 对齐子元素, 通过修改[child!.parentData]这样的方式手势碰撞就会自动计算
  void _alignChild() {
    if (child != null) {
      var dx = 0.0;
      var dy = 0.0;
      switch (alignment) {
        case AlignmentDirectional.topStart:
        case AlignmentDirectional.centerStart:
        case AlignmentDirectional.bottomStart:
          dx = 0;
          break;
        case AlignmentDirectional.topCenter:
        case AlignmentDirectional.center:
        case AlignmentDirectional.bottomCenter:
          dx = (size.width - child!.size.width) / 2;
          break;
        case AlignmentDirectional.topEnd:
        case AlignmentDirectional.centerEnd:
        case AlignmentDirectional.bottomEnd:
          dx = size.width - child!.size.width;
          break;
      }
      switch (alignment) {
        case AlignmentDirectional.topStart:
        case AlignmentDirectional.topCenter:
        case AlignmentDirectional.topEnd:
          dy = 0;
          break;
        case AlignmentDirectional.centerStart:
        case AlignmentDirectional.center:
        case AlignmentDirectional.centerEnd:
          dy = (size.height - child!.size.height) / 2;
          break;
        case AlignmentDirectional.bottomStart:
        case AlignmentDirectional.bottomCenter:
        case AlignmentDirectional.bottomEnd:
          dy = size.height - child!.size.height;
          break;
      }
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset(dx, dy);
    }
  }

  @override
  void performLayout() {
    //debugger();
    if (child == null) {
      size = constraints.smallest;
    } else {
      //在可以滚动的布局中, maxWidth和maxHeight会是无限大
      child!.layout(
        BoxConstraints(
          minWidth: matchWidth ? constraints.maxWidth : constraints.minWidth,
          minHeight:
              matchHeight ? constraints.maxHeight : constraints.minHeight,
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        ),
        parentUsesSize: true,
      );
      size = constraints.constrain(child!.size);
      _alignChild();
    }
  }
}

extension MatchParentLayoutEx on Widget {
  /// [WrapContentLayoutEx.wrapContent]
  MatchParentLayout matchParent({
    bool matchWidth = true,
    bool matchHeight = true,
    AlignmentDirectional alignment = AlignmentDirectional.center,
  }) =>
      MatchParentLayout(
        alignment: alignment,
        matchWidth: matchWidth,
        matchHeight: matchHeight,
        child: this,
      );
}
