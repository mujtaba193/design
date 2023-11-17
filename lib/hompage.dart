import 'package:flutter/material.dart';
import 'package:design/second.dart';

class Hompage extends StatelessWidget {
  const Hompage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
