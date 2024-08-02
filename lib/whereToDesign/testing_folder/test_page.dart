import 'package:flutter/material.dart';

class LineObject {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  const LineObject({
    required this.points,
    this.color = Colors.red,
    this.strokeWidth = 20.0,
  });

  LineObject copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
  }) {
    return LineObject(
      points: points ?? this.points,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}

class FingerPainter extends CustomPainter {
  final LineObject line;
  const FingerPainter({
    required this.line,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = line.color
      ..strokeWidth = line.strokeWidth
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < line.points.length - 1; i++) {
      canvas.drawLine(line.points[i], line.points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(FingerPainter oldDelegate) {
    return line.points.length != oldDelegate.line.points.length;
  }
}

class FingerPainterScreen extends StatefulWidget {
  const FingerPainterScreen({super.key});

  @override
  State<FingerPainterScreen> createState() => _FingerPainterScreenState();
}

class _FingerPainterScreenState extends State<FingerPainterScreen> {
  LineObject line = LineObject(points: []);

  void _onClearLines() {
    setState(() {
      line = LineObject(points: []);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      line = line.copyWith(
        points: [...line.points, details.localPosition],
      );
    });
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      line = LineObject(points: [details.localPosition]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onClearLines,
        child: const Icon(Icons.clear),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: RepaintBoundary(
          child: CustomPaint(
            size: MediaQuery.sizeOf(context),
            painter: FingerPainter(
              line: line,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FingerPainterScreen(),
  ));
}
// Changes made:
//LineObject Class: The LineObject class remains the same but is used to manage a single line.
//FingerPainter Class: The FingerPainter class now receives a single LineObject instance and draws only one line.
//FingerPainterScreen Class:
//Manages a single LineObject instance (line).
//Updated methods (_onPanStart and _onPanUpdate) to modify this single line.
//Removed the list of lines and now directly works with a single line.
//CustomPaint is now wrapped in RepaintBoundary to optimize repainting.
//This setup ensures only one line is drawn and allows you to clear and redraw the line as needed.