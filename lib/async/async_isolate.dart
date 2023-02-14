import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:isolate';
import 'dart:developer' as developer;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsyncIsolateDemo',
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
  State<StatefulWidget> createState() => _SampleAppPage();
}

class _SampleAppPage extends State<SampleAppPage> {

  // TODO：可以优化，widgets弄成实体对象，通过自动序列化
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample App'),
        ),
        body: getBody());
  }

  /// Isolate 之间通讯的方式：port 端口，可以很方便的实现 Isolate 之间的双向通讯，原理是向对方的队列里写入任务
  Future<void> loadData() async {
    // 创建 receivePort 接受端口
    ReceivePort receivePort = ReceivePort();
    // 创建 Isolate，因为这是个异步操作，所以加上 await
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    // 创建 SendPort 发送端口
    SendPort sendPort = await receivePort.first;
    // 发送
    List msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      widgets = msg;
    });
  }

  Future sendReceive(SendPort sendPort, address) {
    ReceivePort response = ReceivePort();
    sendPort.send([address, response.sendPort]);
    return response.first;
  }

  static Future<void> dataLoader(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for (var msg in receivePort) {
      String data = msg[0];
      SendPort replyTo = msg[1];
      String dataURL = data;
      http.Response response = await http.get(Uri.parse(dataURL));
      replyTo.send(jsonDecode(response.body));
      developer.log(response.body);
    }
  }

  Widget getBody() {
    bool showLoadingDialog = widgets.isEmpty;
    if (showLoadingDialog) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      );
    }
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Row$i: ${widgets[i]["title"]}"),
    );
  }

}
