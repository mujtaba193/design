import 'package:design/loover_pages/fourth.dart';
import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third page'),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const ListTile(
            title: Text('image 1'),
            subtitle: Image(image: AssetImage('lib/image/h1.jpg')),
          ),
          const ListTile(
            title: Text('image 2'),
            subtitle: Image(image: AssetImage('lib/image/h2.jpg')),
          ),
          const ListTile(
            title: Text('image 3'),
            subtitle: Image(image: AssetImage('lib/image/h3.jpeg')),
          ),
          const ListTile(
            title: Text('image 4'),
            subtitle: Image(image: AssetImage('lib/image/h4.jpg')),
          ),
          const ListTile(
            title: Text('image 5'),
            subtitle: Image(image: AssetImage('lib/image/h5.jpg')),
          ),
          Container(
            height: 200,
            width: 200,
            color: Colors.red,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.black,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.green,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.yellow,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.blue,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: const Image(image: AssetImage('lib/image/h5.jpg')),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Fourth()));
              },
              child: const Text('go to Fourth'),
            ),
          ),
        ],
      ),
    );
  }
}
