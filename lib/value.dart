import 'package:flutter/material.dart';
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
        decoration: const BoxDecoration(
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
          child: Container(
            width: 200,
            margin: const EdgeInsets.all(5),
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(120),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF8942BC),
                  Color(0xFF5831F7),
                  Color(0xFF5731F8),
                  Color(0xFF00C2C2),
                ],
              ),
            ),
            child: Center(child: Text(tt)),
          ),
        ),
      ),
    );
  }
}
