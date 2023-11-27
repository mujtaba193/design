import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design/svg.dart';

class Val extends StatefulWidget {
  const Val({super.key});

  @override
  State<Val> createState() => _ValState();
}

class _ValState extends State<Val> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          child: Text('${tt}'),
        ),
      ),
    );
  }
}
