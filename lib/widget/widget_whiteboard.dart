import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoApp()));

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Signature());
}

class Signature extends StatefulWidget {
  const Signature({super.key});

  @override
  State<StatefulWidget> createState() => SignatureState();
}

/// ..的作用：级联运算符 (.. or ?..) 可以让你在同一个对象上连续调用多个对象的变量或方法。
class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox? renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition =
                renderBox.globalToLocal(details.globalPosition);
            _points = List.from(_points)..add(localPosition);
          });
        },
        onPanEnd: (details) => _points.add(null),
        child: CustomPaint(
            painter: SignaturePainter(_points), size: Size.infinite));
  }
}

/// 自定义绘制算法，实现手写笔迹
class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  /// 如果新实例表示与旧实例不同的信息，则该方法应返回 true，否则应返回 false
  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
