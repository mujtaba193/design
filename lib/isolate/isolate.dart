import 'package:flutter/material.dart';

class MyIsolate extends StatefulWidget {
  const MyIsolate({super.key});

  @override
  State<MyIsolate> createState() => _MyIsolateState();
}

class _MyIsolateState extends State<MyIsolate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isolate'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
