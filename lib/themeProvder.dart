import 'package:design/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Themee extends ConsumerWidget {
  const Themee({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeVal = ref.watch(themeProvid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeVal ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme'),
          centerTitle: true,
        ),
        body: Center(
          child: Row(
            children: [
              Text('Change to dark mode'),
              Switch(
                value: themeVal,
                onChanged: (value) =>
                    ref.read(themeProvid.notifier).state = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
