import 'package:flutter/material.dart';
import 'package:flutter_match_parent/flutter_match_parent.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static const double height = 46;

  const MainApp({super.key});

  Widget container(Widget child) => Container(
        color: Colors.red,
        constraints: const BoxConstraints(
          minHeight: height,
          maxHeight: height,
        ),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        child: child,
      );

  Widget textWidget({
    Color color = Colors.white,
    String text = "文本内容",
  }) =>
      Container(
        color: color,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
          ),
          textAlign: TextAlign.center,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var m = 8;
    var wm = 4;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_match_parent'),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Text(
                "在普通容器(Container)中↓",
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "正常布局(适应)"),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "正常布局" * m),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "match_parent布局(强行撑满)").matchParent(),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "match_parent布局" * wm).matchParent(),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "在容器(Row)中↓",
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [Expanded(child: textWidget(text: "正常布局(适应)"))],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [Expanded(child: textWidget(text: "正常布局" * m))],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    Expanded(
                        child: textWidget(text: "match_parent布局(强行撑满)")
                            .matchParent())
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    Expanded(
                        child: textWidget(text: "match_parent布局" * wm)
                            .matchParent())
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "在容器(Row-Expanded)中↓",
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    container(textWidget(text: "Left")),
                    Expanded(child: textWidget(text: "正常布局(适应)")),
                    container(textWidget(text: "Right")),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    container(textWidget(text: "Left")),
                    Expanded(child: textWidget(text: "正常布局" * m)),
                    container(textWidget(text: "Right")),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    container(textWidget(text: "Left")),
                    Expanded(
                        child: textWidget(text: "match_parent布局(强行撑满)")
                            .matchParent()),
                    container(textWidget(text: "Right")),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    container(textWidget(text: "Left")),
                    Expanded(
                        child: textWidget(text: "match_parent布局" * wm)
                            .matchParent()),
                    container(textWidget(text: "Right")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
