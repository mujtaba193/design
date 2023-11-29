import 'package:design/fourth.dart';
import 'package:design/hompage.dart';
import 'package:design/loovr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third page'),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            title: Text('image 1'),
            subtitle: Image(image: AssetImage('lib/image/h1.jpg')),
          ),
          ListTile(
            title: Text('image 2'),
            subtitle: Image(image: AssetImage('lib/image/h2.jpg')),
          ),
          ListTile(
            title: Text('image 3'),
            subtitle: Image(image: AssetImage('lib/image/h3.jpeg')),
          ),
          ListTile(
            title: Text('image 4'),
            subtitle: Image(image: AssetImage('lib/image/h4.jpg')),
          ),
          ListTile(
            title: Text('image 5'),
            subtitle: Image(image: AssetImage('lib/image/h5.jpg')),
          ),
          Container(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.green,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.yellow,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.blue,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 80,
                  width: 80,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Image(image: AssetImage('lib/image/h5.jpg')),
                ),
              ],
            ),
            height: 200,
            width: 200,
            color: Colors.red,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Fourth()));
              },
              child: Text('go to Fourth'),
            ),
          ),
        ],
      ),
    );
  }
}
