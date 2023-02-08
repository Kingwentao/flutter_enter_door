import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {

  const SampleAppPage({super.key});

  @override
  State<StatefulWidget> createState() => _SampleAppPageState();

}

/// 在布局中切换组件
/// 在 Flutter 中，由于 Widget 是不可变的，所以没有 addChild() 的直接对应的方法。
/// 不过，你可以给返回一个 Widget 的父 Widget 传入一个方法，并通过布尔标记值控制子 Widget 的创建。
/// example: 点击一个 FloatingActionButton 时在两个 widget 之间切换。
class _SampleAppPageState extends State<SampleAppPage> {

  bool toggle = true;

  int a = 1;

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return const Text("Toggle One");
    } else {
      a++;
      return ElevatedButton(onPressed: () {}, child: Text('Toggle $a'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: _getToggleChild()),
      floatingActionButton: FloatingActionButton(
          onPressed: _toggle,
          tooltip: 'Update Widget',
          child: const Icon(Icons.update)),
    );
  }
}