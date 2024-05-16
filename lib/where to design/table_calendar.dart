import 'package:design/where%20to%20design/Calendar%20classes/table_basic.dart';
import 'package:flutter/material.dart';

class TableCalendar extends StatefulWidget {
  const TableCalendar({super.key});

  @override
  State<TableCalendar> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Basics'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableBasic()),
              ),
            ),
            const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Range Selection'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableRangeExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Events'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableEventsExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Multiple Selection'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableMultiExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Complex'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableComplexExample()),
            //   ),
            // ),
            // const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
