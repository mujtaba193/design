import 'package:flutter/material.dart';
import 'package:design/loovr.dart';
import 'package:go_router/go_router.dart';
import 'package:design/model2.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class Hompage extends StatefulWidget {
  bool isUserLoggedIn;
  Hompage({super.key, required this.isUserLoggedIn});

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  List<bool> isSelecte = [true, false];
  //List.generate(2, (index) => false); // 'Еженедельно', 'Ежемесячно'
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
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push("/futureProvider");
                },
                child: Text('go to provoider'),
              ),
            ),
            SizedBox(height: 400),
            ToggleButtons(
              borderRadius: BorderRadius.circular(999),
              borderWidth: 1,
              borderColor: Color(0xFF696868),
              fillColor: Color(0xFF714BD8).withOpacity(0.25),
              selectedColor: Color(0xFF714BD8),
              //borderColor: Color(0xFF714BD8),
              children: [
                SelectableText(
                  'Еженедельно',
                  style: TextStyle(
                    color: Color(0xFF696868),
                  ),
                ),
                SelectableText(
                  'Еженедельно',
                  style: TextStyle(
                    color: Color(0xFF696868),
                  ),
                ),
              ],
              isSelected: isSelecte,
              onPressed: (int indexx) {
                setState(() {
                  for (int i = 0; i < isSelecte.length; i++) {
                    if (i == indexx) {
                      isSelecte[i] = true;
                    } else {
                      isSelecte[i] = false;
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
