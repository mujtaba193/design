import 'package:flutter/material.dart';
import 'package:design/loovr.dart';
import 'package:go_router/go_router.dart';
import 'package:design/model2.dart';

class Hompage extends StatefulWidget {
  bool isUserLoggedIn;
  Hompage({super.key, required this.isUserLoggedIn});

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            //Color(0xFF8942BC),
            Color(0xFF5831F7),
            // Color(0xFF5731F8),
            Color(0xFF000000),
            Color(0xFF000000),
            Color(0xFF000000),
          ], focal: Alignment.topLeft, radius: 1.4),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push("/futureProvider");
            },
            child: Text('go to provoider'),
          ),
        ),
      ),
    );
  }
}
