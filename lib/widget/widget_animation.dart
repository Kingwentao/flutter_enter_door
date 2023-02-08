import 'package:flutter/material.dart';

void main() {
  runApp(const FadeAppTest());
}

class FadeAppTest extends StatelessWidget {
  const FadeAppTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue // 主色
      ),
      home: const MyFadeTest(title: 'Fade Demo'),
    );
  }
}

/// required作用：Dart中的required关键词已经作为内置修饰符。
/// 主要用于允许根据需要标记任何命名参数（函数或类），使得它们不为空。因为可选参数中必须有个 required 参数或者该参数有个默认值。
class MyFadeTest extends StatefulWidget {

  final String title;

  const MyFadeTest({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MyFadeTest();

}

/// with作用：Dart 支持 Mixin ，而 Mixin 能够更好的解决 多继承 中容易出现的问题，
/// 如： 方法优先顺序混乱、参数冲突、类结构变得复杂化等等。结论上简单来说，就是相同方法被覆盖了，并且 with 后面的会覆盖前面的。

/// TickerProviderStateMixin 作用：使用Animation controller时，需要在控制器初始化时传递一个vsync参数，此时需要用到TickerProvider
/// SingleTickerProviderStateMixin只适用于单个AnimationController的情况，如需使用多个AnimationController，请使用TickerProviderStateMixin

/// CurvedAnimation: 为非线性曲线

/// override initState：覆盖此方法以执行初始化，这取决于此对象插入树中的位置（即 [context]）或用于配置此对象的小部件（即 [widget]）。

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {

  late AnimationController controller;

  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    curvedAnimation =
        CurvedAnimation(parent: (controller), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FadeTransition(
          opacity: curvedAnimation,
          child: const FlutterLogo(size: 100.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade Animation',
        onPressed: () {
          controller.forward(); // ???
        },
        child: const Icon(Icons.brush),
      ),
    );
  }
}