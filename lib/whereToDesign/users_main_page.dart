import 'dart:convert';

import 'package:design/whereToDesign/models/user_model.dart';
import 'package:flutter/material.dart';

class UsersMainPage extends StatefulWidget {
  const UsersMainPage({super.key});

  @override
  State<UsersMainPage> createState() => _UsersMainPageState();
}

class _UsersMainPageState extends State<UsersMainPage> {
  List<UsersModel>? usersd;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    var response = await DefaultAssetBundle.of(context)
        .loadString('asset/user_booking.json');
    List<dynamic> usersList = json.decode(response);
    setState(() {
      usersd = usersList.map((e) => UsersModel.fromJson(e)).toList();
    });
    // usersd = usersList.map((e) => UsersModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // offset: Offset(4.0, 4.0),
                          blurRadius: 10,
                          spreadRadius: 2),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              if (usersd != null)
                ListView.builder(
                    itemCount: usersd!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(usersd![index].name),
                        subtitle: Text(usersd![index].review),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Start: ${usersd![index].bookedStartTime}'),
                            Text('End: ${usersd![index].bookedFinishTime}'),
                          ],
                        ),
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
