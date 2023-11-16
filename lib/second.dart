import 'package:design/third.dart';
import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second page'),
        backgroundColor: Colors.blue[200],
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Third()));
          },
          child: Text('go to third'),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
