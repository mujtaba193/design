import 'package:flutter/material.dart';
import 'package:design/geoloc.dart';

class Fourth extends StatelessWidget {
  const Fourth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fourth page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          children: [
            Container(
              height: 200,
              color: Colors.red,
              child: const Center(
                child: Text('firsr'),
              ),
            ),
            Container(
              height: 200,
              color: Colors.blue,
              child: const Center(
                child: Text('second'),
              ),
            ),
            Container(
              height: 200,
              color: Colors.yellow,
              child: const Center(
                child: Text('third'),
              ),
            ),
            Container(
              height: 200,
              color: Colors.green,
              child: const Center(
                child: Text('fourth'),
              ),
            ),
            Container(
              height: 200,
              color: Colors.grey,
              child: const Center(
                child: Text('fifth'),
              ),
            ),
            Container(
              height: 200,
              color: Colors.purple,
              child: const Center(
                child: Text('firsr'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const model(),
                    ),
                  );
                },
                child: const Text('go to model'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
