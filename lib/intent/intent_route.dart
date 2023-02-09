import 'package:flutter/material.dart';

/// 定义一个 route 名字的 Map  (MaterialApp)
/// 直接导航到一个 route  (WidgetApp)
void main() {
  runApp(MaterialApp(
    home: const MyAppHome(), // Becomes the route named '/'.
    routes: <String, WidgetBuilder>{
      '/a': (context) => const Center(
            child: MyPage('page A'),
          ),
      '/b': (context) => const Center(
            child: MyPage('page B'),
          ),
      '/c': (context) => const MyPage('page C'),
    },
  ));
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({super.key});

  @override
  State<StatefulWidget> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<MyAppHome> {
  String textToShow = 'I Try Learn Flutter';

  void updateText() {
    setState(() {
      // 通过路由名 压栈 (push) 到 Navigator 中来跳转到这个 route。
      Navigator.of(context).pushNamed('/a');
      Navigator.of(context).pushNamed('/b');
      Navigator.of(context).pushNamed('/c');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final String title;

  const MyPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(title),
    );
  }
}
