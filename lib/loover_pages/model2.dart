import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class UseresModel extends StatefulWidget {
  const UseresModel({super.key});

  @override
  State<UseresModel> createState() => _UseresModelState();
}

class _UseresModelState extends State<UseresModel> {
  Future<List<User>> _getUsers() async {
    var response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/JohannesMilke/futurebuilder_example/master/assets/users.json"));
    var body = await json.decode(response.body);
    List<User> users = [];
    for (var i in body) {
      User val = User(i["username"], i["email"], i["urlAvatar"]);
      users.add(val);
      print(users);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 19, 18, 18),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Center(
                  child: Text('downloading...'),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].urlAvatar),
                      ),
                      title: Text(
                        snapshot.data[index].username,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        snapshot.data[index].email,
                        style: const TextStyle(color: Colors.white60),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 54, 52, 52),
      drawer: const Drawer(),
    );
  }
}

class User {
  final String username;
  final String email;
  final String urlAvatar;
  User(this.username, this.email, this.urlAvatar);
}










// https://raw.githubusercontent.com/JohannesMilke/futurebuilder_example/master/assets/users.json