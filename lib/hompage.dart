import 'package:flutter/material.dart';
import 'package:design/second.dart';

class Hompage extends StatelessWidget {
  const Hompage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home page',
        ),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Center(
        child: ElevatedButton(
          child: Text('go to second'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Second(),
              ),
            );
          },
        ),
      ),
    );
  }
}
