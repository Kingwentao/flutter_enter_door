import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SelfDefineWidgetApp()));

class SelfDefineWidgetApp extends StatelessWidget {
  const SelfDefineWidgetApp({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: SelfDefineWidget());
}

/// 自定义Widget
class SelfDefineWidget extends StatelessWidget {
  const SelfDefineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomButton('自定义Widget'),
    );
  }
}

/// 自定义一个带文本的按钮
class CustomButton extends StatelessWidget {
  final String label;

  const CustomButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
